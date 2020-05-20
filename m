From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf bpf-loader: Add missing '*' for key_scan_pos
Date: Wed, 20 May 2020 12:30:06 +0200
Message-ID: <20200520103006.GA157452@krava>
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
Cc: cj.chengjian@huawei.com, huawei.libin@huawei.com, xiexiuqi@huawei.com, mark.rutland@arm.com, guohanjun@huawei.com, acme@kernel.org, alexander.shishkin@linux.intel.com, wangnan0@huawei.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, May 20, 2020 at 06:22:12PM +0800, Wangshaobo (bobo) wrote:
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

and what's the actual problem, what's broken?

jirka

> 
>   thanks,
> 
>   Wang ShaoBo
> 
> 
