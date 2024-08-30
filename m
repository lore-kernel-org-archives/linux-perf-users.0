Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C113E3F5;
	Fri, 30 Aug 2024 04:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724992797; cv=none; b=DkfxeIX86fPp8KS8mFP3P6CDZCi9OG58BRGi0fzfz1Y/lT3xfhc+Op0LeIdHU0iIjn/1jRohT/tqplYhDJO5AyymxgflsgwRgGxNDMvYIL7bY+1oo/3MraasGk9A8T1rOsRzk09IKMmdYjiNXVEWDP/JGeAtuDbrNiDGRLVm+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724992797; c=relaxed/simple;
	bh=6fawuMmQETiBDWzELiPYS+rDeo28n5CAKxJCNKIchlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brFiqyiAopqdSIfx8jGHj2e/p5g9yRvH9oNl27CYHkcAM3ny7EY+2bdX2VdstRlk3Ery9iLxhwjwc7Bh7bjhWPt5dGYu1/JUHSDMixP/mHOSondef4o9alqdAyMUWaqB8zPDsMnwvNW4bedKR2BQXjfr2rDIN/gu2sdl66NJrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r457JfOt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r457JfOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064F1C4CEC4;
	Fri, 30 Aug 2024 04:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724992796;
	bh=6fawuMmQETiBDWzELiPYS+rDeo28n5CAKxJCNKIchlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r457JfOtDIPEHtBIKHOUdQ31Q9p1jmYhqmToe7QeD4DLNLDqKDZwJVsv1xnvj1isk
	 1OHkpN/yBGR3w2kRYta90lCDGBDaijKbLCbbggYpZhTLkp/49wAJXftKCplfx0MdFY
	 qzPR4CkAkZ0DAqguPoRfoB0f4vz78HWlKzObUb8+UbcEC/sTXwQenYnVwNHKrKHXgb
	 AmCq78cfMWlXBoxQKIx0qhjl2xIupOr4/zjrCEwkJ9XJQE9PfgVGzrh36DufmYgtvV
	 qHXfSOV7Qn4tiHylftx1SFR1qLcOVTZSWcTtx26C+UUzlb9xjRDeJInnjsXssKbFS6
	 Ym2ruECD+z5RQ==
Date: Thu, 29 Aug 2024 21:39:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>, Yanteng Si <siyanteng@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/8] perf header: Allow attributes to be written after
 data
Message-ID: <ZtFNGuwj0WzRQ8fd@google.com>
References: <20240829150154.37929-1-irogers@google.com>
 <20240829150154.37929-6-irogers@google.com>
 <ZtDMf886_1vXWt49@x1>
 <CAP-5=fURe7yVy6OGWdKn1eSzsdfZPyvvc5fRMPeNAjukaWOe1w@mail.gmail.com>
 <ZtDg2BAI0V5zKpjn@x1>
 <CAP-5=fXa0r7sD9xbtBVbJQFgnq=3i-cnj6gUX9tze0JyhLhvZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXa0r7sD9xbtBVbJQFgnq=3i-cnj6gUX9tze0JyhLhvZw@mail.gmail.com>

On Thu, Aug 29, 2024 at 02:42:38PM -0700, Ian Rogers wrote:
> On Thu, Aug 29, 2024 at 1:58 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Aug 29, 2024 at 01:12:32PM -0700, Ian Rogers wrote:
> > > On Thu, Aug 29, 2024 at 12:31 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 29, 2024 at 08:01:51AM -0700, Ian Rogers wrote:
> > > > > With a file, to write data an offset needs to be known. Typically data
> > > > > follows the event attributes in a file. However, if processing a pipe
> > > > > the number of event attributes may not be known. It is convenient in
> > > > > that case to write the attributes after the data. Expand
> > > > > perf_session__do_write_header to allow this when the data offset and
> > > > > size are known.
> > > > >
> > > > > This approach may be useful for more than just taking a pipe file to
> > > > > write into a data file, `perf inject --itrace` will reserve and
> > > > > additional 8kb for attributes, which would be unnecessary if the
> > > > > attributes were written after the data.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/perf/util/header.c | 106 +++++++++++++++++++++++++--------------
> > > > >  1 file changed, 67 insertions(+), 39 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > > > index 65c9086610cb..4eb39463067e 100644
> > > > > --- a/tools/perf/util/header.c
> > > > > +++ b/tools/perf/util/header.c
> > > > > @@ -3676,32 +3676,50 @@ int perf_header__write_pipe(int fd)
> > > > >  static int perf_session__do_write_header(struct perf_session *session,
> > > > >                                        struct evlist *evlist,
> > > > >                                        int fd, bool at_exit,
> > > > > -                                      struct feat_copier *fc)
> > > > > +                                      struct feat_copier *fc,
> > > > > +                                      bool write_attrs_after_data)
> > > > >  {
> > > > >       struct perf_file_header f_header;
> > > > > -     struct perf_file_attr   f_attr;
> > > > >       struct perf_header *header = &session->header;
> > > > >       struct evsel *evsel;
> > > > >       struct feat_fd ff = {
> > > > >               .fd = fd,
> > > > >       };
> > > > > -     u64 attr_offset;
> > > > > +     u64 attr_offset = sizeof(f_header), attr_size = 0;
> > > > >       int err;
> > > > >
> > > > > -     lseek(fd, sizeof(f_header), SEEK_SET);
> > > > > +     if (write_attrs_after_data && at_exit) {
> > > > > +             /*
> > > > > +              * Write features at the end of the file first so that
> > > > > +              * attributes may come after them.
> > > > > +              */
> > > > > +             if (!header->data_offset && header->data_size) {
> > > > > +                     pr_err("File contains data but offset unknown\n");
> > > > > +                     err = -1;
> > > > > +                     goto err_out;
> > > > > +             }
> > > > > +             header->feat_offset = header->data_offset + header->data_size;
> > > > > +             err = perf_header__adds_write(header, evlist, fd, fc);
> > > > > +             if (err < 0)
> > > > > +                     goto err_out;
> > > > > +             attr_offset = lseek(fd, 0, SEEK_CUR);
> > > > > +     } else {
> > > > > +             lseek(fd, attr_offset, SEEK_SET);
> > > > > +     }
> > > > >
> > > > >       evlist__for_each_entry(session->evlist, evsel) {
> > > > > -             evsel->id_offset = lseek(fd, 0, SEEK_CUR);
> > > > > -             err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
> > > > > -             if (err < 0) {
> > > > > -                     pr_debug("failed to write perf header\n");
> > > > > -                     free(ff.buf);
> > > > > -                     return err;
> > > > > +             evsel->id_offset = attr_offset;
> > > > > +             /* Avoid writing at the end of the file until the session is exiting. */
> > > > > +             if (!write_attrs_after_data || at_exit) {
> > > > > +                     err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
> > > > > +                     if (err < 0) {
> > > > > +                             pr_debug("failed to write perf header\n");
> > > > > +                             goto err_out;
> > > > > +                     }
> > > > >               }
> > > > > +             attr_offset += evsel->core.ids * sizeof(u64);
> > > >
> > > > So in the past we were using lseek(fd, 0, SEEK_CUR) to set the
> > > > evsel->id_offset, now you're assuming that do_write will honour the size
> > > > parameter, i.e. write evsel->core.ids * sizeof(u64), but:
> > > >
> > > > /* Return: 0 if succeeded, -ERR if failed. */
> > > > int do_write(struct feat_fd *ff, const void *buf, size_t size)
> > > > {
> > > >         if (!ff->buf)
> > > >                 return __do_write_fd(ff, buf, size);
> > > >         return __do_write_buf(ff, buf, size);
> > > > }
> > > >
> > > > And then:
> > > >
> > > > static int __do_write_fd(struct feat_fd *ff, const void *buf, size_t size)
> > > > {
> > > >         ssize_t ret = writen(ff->fd, buf, size);
> > > >
> > > >         if (ret != (ssize_t)size)
> > > >                 return ret < 0 ? (int)ret : -1;
> > > >         return 0;
> > > > }
> > > >
> > > > I see that writen calls ion that even has a BUG_ON() if it doesn't write
> > > > exactly the requested size bytes, I got distracted with __do_write_fd
> > > > extra check that ret != size returning ret if not negative...
> > > >
> > > > I.e. your code _should_ be equivalent due to the check in ion(), and
> > > > taking that as an assumption you reduce the number of lseek syscalls,
> > > > which is a good thing...
> > > >
> > > > I was just trying to see that the !write_attrs_after_data case was
> > > > _exactly_ the same as before, which it doesn't look like it is :-\
> > >
> > > I'm not seeing the difference. Before:
> >
> > You noticed the difference: before we used lseek to get the current
> > offset to use, afterwards we moved to doing plain math.
> >
> > So I had to check if we could assume that, and with the current code
> > structure, yes, we can assume that, so seems safe, but it is different
> > and if the assumption somehow breaks, as the code in __do_write_fd()
> > guard against (unneeded at the moment as ion has even a BUG_ON for that
> > not to happen), then the offset will not be where the data is.
> >
> > Using lseek() is more costly (syscalls) but it is the ultimate answer to
> > get where in the file the current offset is.
> >
> > So that is the difference I noticed.
> >
> > Doing multiple things in the same patch causes these reviewing delays,
> > doubts, its something we discussed multiple times in the past, and that
> > continue to cause these discussions.
> 
> Right, but it is something of an unfortunate coincidence of how the
> code is structured. The fact that writing the header updates
> data_offset which is a thing that other things depend upon while
> depending on its value itself, etc. - ie the function does more than
> just a write, it also sometimes computes the layout, has inbuilt
> assumptions on the values lseek will return, and so on. To get to this
> final structure took a fair few iterations and I've separated this
> change out from the bulk in the next change to keep the patch size
> down. I could have done a patch switching from lseeks to math, then a
> patch to add write_attrs_after_data. It probably would have yielded
> about 4 lines of shared code, more lines that would have been deleted,
> while creating quite a bit of work for me. Ideally when these
> functions were created there would have been far more liberal use of
> things like immutability, so side-effects are minimized. Yes I could
> refactor everything, but time..

Maybe I'm too naive but can we skip header updates on pipe data?  I'm
curious if this makes sense..

Thanks,
Namhyung


diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a7c859db2e15..b36f84f29295 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2341,6 +2341,9 @@ int cmd_inject(int argc, const char **argv)
        if (ret)
                goto out_delete;
 
+       if (data.is_pipe)
+               inject.is_pipe = true;
+
        if (!data.is_pipe && inject.output.is_pipe) {
                ret = perf_header__write_pipe(perf_data__fd(&inject.output));
                if (ret < 0) {

