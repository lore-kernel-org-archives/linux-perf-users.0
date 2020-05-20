From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf bpf-loader: Add missing '*' for key_scan_pos
Date: Wed, 20 May 2020 11:30:14 -0300
Message-ID: <20200520143014.GJ32678@kernel.org>
References: <20200520033216.48310-1-bobo.shaobowang@huawei.com>
 <20200520070551.GC110644@krava>
 <ac38c44e-ebce-28eb-37f5-bf05572b9232@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ac38c44e-ebce-28eb-37f5-bf05572b9232@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>, cj.chengjian@huawei.com, huawei.libin@huawei.com, xiexiuqi@huawei.com, mark.rutland@arm.com, guohanjun@huawei.com, alexander.shishkin@linux.intel.com, wangnan0@huawei.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, May 20, 2020 at 06:22:12PM +0800, Wangshaobo (bobo) escreveu:
> 
> 在 2020/5/20 15:05, Jiri Olsa 写道:
> > On Wed, May 20, 2020 at 11:32:16AM +0800, Wang ShaoBo wrote:
> > > key_scan_pos is a pointer for getting scan position in
> > > bpf__obj_config_map() for each BPF map configuration term,
> > > but it's misused when error not happened.
> > > 
> > > Fixes: 066dacbf2a32 ("perf bpf: Add API to set values to map entries in a bpf object")
> > > Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> > > ---
> > >   tools/perf/util/bpf-loader.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > > index 10c187b8b8ea..460056bc072c 100644
> > > --- a/tools/perf/util/bpf-loader.c
> > > +++ b/tools/perf/util/bpf-loader.c
> > > @@ -1225,7 +1225,7 @@ bpf__obj_config_map(struct bpf_object *obj,
> > >   out:
> > >   	free(map_name);
> > >   	if (!err)
> > > -		key_scan_pos += strlen(map_opt);
> > > +		*key_scan_pos += strlen(map_opt);
> > seems good, was there something failing because of this?
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > thanks,
> > jirka
> 
>   I found this problem when i checked this code, I think it is
> 
>   an implicit question, but if we delete the two line,  the problem
> 
>   also no longer exists.

The point is that the only user of this is:

  tools/perf/util/parse-events.c
    err = bpf__config_obj(obj, term, parse_state->evlist, &error_pos);
      if (err) bpf__strerror_config_obj(obj, term, parse_state->evlist, &error_pos, err, errbuf, sizeof(errbuf));


And then:

int bpf__strerror_config_obj(struct bpf_object *obj __maybe_unused,
                             struct parse_events_term *term __maybe_unused,
                             struct evlist *evlist __maybe_unused,
                             int *error_pos __maybe_unused, int err,
                             char *buf, size_t size)
{
        bpf__strerror_head(err, buf, size);
        bpf__strerror_entry(BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE,
                            "Can't use this config term with this map type");
        bpf__strerror_end(buf, size);
        return 0;
}

        
So this is infrastructure that Wang Nan put in place for providing
better error messages but that he ended up not using, so I'll apply the
fix, its correct even not fixing any real problem at this time.

- Arnaldo
