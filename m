Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E423D331B;
	Thu, 19 Mar 2026 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955793; cv=none; b=JED4MpxsMRWYJ3WnU+Li0CR+vkrTwWYuzIjFgTSZBDgv4gTrvk8JMjySqiS9Ept5e2nQYCAyL1dxAjsMYl8NAxuCzHD8rEzEkaObaxSLVDDP7otjqN8x22+IqVRq3nRqe+jXaYboHALAh1OW444oG80aXX/0Fe7rFzf6XP6vmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955793; c=relaxed/simple;
	bh=27GXIBI1vToPPkBGFI7yFUONCgw3el/DkvcRL/cWpmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahwGmBmeJThCQ2EjvwZUQAR5FBr836hS06zF/08CsYvFWYDJZwxhc8FvHAdI/WB2lgpMmXQ+kCA+YqTgBCMKfG4TgIens7EZMNDCdNBlUhxWDAJNAoBJZo6KiH3OvyNDRtbO792KgRofB/Lgoz0ZiBaxxseOyzOiDJAncnYasA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSdH4Psr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSdH4Psr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED525C19424;
	Thu, 19 Mar 2026 21:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773955793;
	bh=27GXIBI1vToPPkBGFI7yFUONCgw3el/DkvcRL/cWpmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSdH4Psr/R91Fxzb3JlB1MZrueoo3lN41flbvxe6XyL+B4k0d+0x/DG8QEc3Zlhp6
	 Amk8ewo65L2iYPFFm45xW2J8ZoDqzAoXurZpMUfI7CaNgWSLn7Gpkof/qV/FmRM0ci
	 I9Uowk83jt/YLoXbUVDxlu9SePdNH/StRQ6nt2cHVVmkYlOboNrvKAMTv4Vt30rVuy
	 kGHF44Uag6A18eNZnpLd5V4oTo507V9tIet7QpqD0KQZJSVXTi6+ylhq+ckasOjX6N
	 cfMpXyeM9D6mK5moOFjmmyBRV2EEZZbkicNcJLq3jbw+Cm5Nyf8HW+h2MUmD17LOJe
	 0IBI93YUo8ySw==
Date: Thu, 19 Mar 2026 14:29:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ricky Ringler <ricky.ringler@proton.me>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	Tianyou Li <tianyou.li@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v2] tools: perf: add comm_ignore_digit column
Message-ID: <abxqz93jZSWcfdt8@google.com>
References: <20260316175631.3169955-1-stephen.s.brennan@oracle.com>
 <CAP-5=fWFrDaG7dCT2AcEAu28aAPKz6qMtpzmrG+4-vn1NLQ--Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWFrDaG7dCT2AcEAu28aAPKz6qMtpzmrG+4-vn1NLQ--Q@mail.gmail.com>

Hello,

On Tue, Mar 17, 2026 at 09:14:50AM -0700, Ian Rogers wrote:
> On Mon, Mar 16, 2026 at 10:56 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
> >
> > The "comm" column allows grouping events by the process command. It is
> > intended to group like programs, despite having different PIDs. But some
> > workloads may adjust their own command, so that a unique identifier
> > (e.g. a PID or some other numeric value) is part of the command name.
> > This destroys the utility of "comm", forcing perf to place each unique
> > process name into its own bucket, which can contribute to a
> > combinatorial explosion of memory use in perf report.
> >
> > Create a less strict version of this column, which ignores digits when
> > comparing command names. This allows "similar looking" processes to
> > again be placed in the same bucket.

Can you please include an example of this change so that others can
notice what's going on?

Actually I'm not happy with the name "comm_ignore_digit".  While it's
intuitive, it would be nice if we have a shorter name.  But maybe we
can just go with it unless someone has a better idea.

> >
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > ---
> >
> > Changes from v1:
> > - Rebased on linux-tools-next. Resolved conflict with commit cbd41c6d4c26c
> >   ("perf report: Update sort key state from -F option").
> >
> > v1: https://lore.kernel.org/linux-perf-users/20260305181847.3249498-1-stephen.s.brennan@oracle.com/
> >
> >  tools/perf/util/hist.c |  1 +
> >  tools/perf/util/hist.h |  1 +
> >  tools/perf/util/sort.c | 92 +++++++++++++++++++++++++++++++++++++++++-
> >  tools/perf/util/sort.h |  1 +
> >  4 files changed, 94 insertions(+), 1 deletion(-)

Also please update the man page in the Documentation.

> >
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 7ffaa3d9851b4..a6e566dda3a15 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -110,6 +110,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
> >         len = thread__comm_len(h->thread);
> >         if (hists__new_col_len(hists, HISTC_COMM, len))
> >                 hists__set_col_len(hists, HISTC_THREAD, len + 8);
> > +       hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len);
> 
> Thanks for working on this! Sashiko is noting some nits in its review:
> https://sashiko.dev/#/patchset/20260316175631.3169955-1-stephen.s.brennan%40oracle.com
> 
> Because hist_entry__comm_ignore_digit_snprintf() replaces consecutive digits
> with the 3-character string <N>, the formatted string is often longer than
> the original string (e.g., a command named worker_1 expands from 8 to 10
> characters: worker_<N>).
> 
> Since the snprintf logic strictly bounds the output to the calculated width,
> will the expanded output be prematurely truncated in reports?

Right.  You can add perf_hpp_list.comm_ignore_digit field and update it
the column length properly only if it's set.

Thanks,
Namhyung

> 
> >
> >         if (h->ms.map) {
> >                 len = dso__name_len(map__dso(h->ms.map));
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 1d5ea632ca4e1..ae7e98bd9e46d 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -44,6 +44,7 @@ enum hist_column {
> >         HISTC_THREAD,
> >         HISTC_TGID,
> >         HISTC_COMM,
> > +       HISTC_COMM_IGNORE_DIGIT,
> >         HISTC_CGROUP_ID,
> >         HISTC_CGROUP,
> >         HISTC_PARENT,
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index 42d5cd7ef4e23..45662302ed5ba 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -1,4 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#include <ctype.h>
> >  #include <errno.h>
> >  #include <inttypes.h>
> >  #include <regex.h>
> > @@ -265,6 +266,93 @@ struct sort_entry sort_comm = {
> >         .se_width_idx   = HISTC_COMM,
> >  };
> >
> > +/* --sort comm_ignore_digit */
> > +
> > +static int64_t strcmp_nodigit(const char *left, const char *right)
> > +{
> > +       for (;;) {
> > +               while (*left && isdigit(*left))
> > +                       left++;
> > +               while (*right && isdigit(*right))
> > +                       right++;
> > +               if (*left == *right && !*left) {
> > +                       return 0;
> > +               } else if (*left == *right) {
> > +                       left++;
> > +                       right++;
> > +               } else {
> > +                       return (int64_t)*left - (int64_t)*right;
> > +               }
> > +       }
> > +}
> 
> Sashiko also notes what's below, but I sent out a patch to make all
> chars unsigned (like the kernel):
> https://lore.kernel.org/lkml/20260306191908.2065682-1-irogers@google.com/
> but it has no reviews.
> 
> Process command strings can contain arbitrary non-ASCII bytes (e.g., UTF-8
> characters). On architectures where char is signed, these bytes evaluate as
> negative integers.
> 
> Passing a negative value (other than EOF) to ctype.h's isdigit() causes
> undefined behavior. In glibc, it results in an out-of-bounds read on the
> __ctype_b_loc array, which can lead to a segmentation fault.
> 
> Additionally, if char is signed, returning (int64_t)*left - (int64_t)*right
> means non-ASCII characters will mathematically sort before ASCII characters.
> 
> Does this code need to cast the characters to unsigned char before passing
> them to isdigit() and subtracting them?
> 
> Thanks,
> Ian
> 
> 
> > +
> > +static int64_t
> > +sort__comm_ignore_digit_cmp(struct hist_entry *left, struct hist_entry *right)
> > +{
> > +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
> > +}
> > +
> > +static int64_t
> > +sort__comm_ignore_digit_collapse(struct hist_entry *left, struct hist_entry *right)
> > +{
> > +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
> > +}
> > +
> > +static int64_t
> > +sort__comm_ignore_digit_sort(struct hist_entry *left, struct hist_entry *right)
> > +{
> > +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
> > +}
> > +
> > +static int hist_entry__comm_ignore_digit_snprintf(struct hist_entry *he, char *bf,
> > +                                               size_t size, unsigned int width)
> > +{
> > +       int ret = 0;
> > +       unsigned int print_len, printed = 0, start = 0, end = 0;
> > +       bool in_digit;
> > +       const char *comm = comm__str(he->comm), *print;
> > +
> > +       while (printed < width && printed < size && comm[start]) {
> > +               in_digit = !!isdigit(comm[start]);
> > +               end = start + 1;
> > +               while (comm[end] && !!isdigit(comm[end]) == in_digit)
> > +                       end++;
> > +               if (in_digit) {
> > +                       print_len = 3; /* <N> */
> > +                       print = "<N>";
> > +               } else {
> > +                       print_len = end - start;
> > +                       print = &comm[start];
> > +               }
> > +               print_len = min(print_len, width - printed);
> > +               ret = repsep_snprintf(bf + printed, size - printed, "%-.*s",
> > +                                       print_len, print);
> > +               if (ret < 0)
> > +                       return ret;
> > +               start = end;
> > +               printed += ret;
> > +       }
> > +       /* Pad to width if necessary */
> > +       if (printed < width && printed < size) {
> > +               ret = repsep_snprintf(bf + printed, size - printed, "%-*.*s",
> > +                                      width - printed, width - printed, "");
> > +               if (ret < 0)
> > +                       return ret;
> > +               printed += ret;
> > +       }
> > +       return printed;
> > +}
> > +
> > +struct sort_entry sort_comm_ignore_digit = {
> > +       .se_header      = "CommandIgnoreDigit",
> > +       .se_cmp         = sort__comm_ignore_digit_cmp,
> > +       .se_collapse    = sort__comm_ignore_digit_collapse,
> > +       .se_sort        = sort__comm_ignore_digit_sort,
> > +       .se_snprintf    = hist_entry__comm_ignore_digit_snprintf,
> > +       .se_filter      = hist_entry__thread_filter,
> > +       .se_width_idx   = HISTC_COMM_IGNORE_DIGIT,
> > +};
> > +
> >  /* --sort dso */
> >
> >  static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
> > @@ -2583,6 +2671,7 @@ static struct sort_dimension common_sort_dimensions[] = {
> >         DIM(SORT_PID, "pid", sort_thread),
> >         DIM(SORT_TGID, "tgid", sort_tgid),
> >         DIM(SORT_COMM, "comm", sort_comm),
> > +       DIM(SORT_COMM_IGNORE_DIGIT, "comm_ignore_digit", sort_comm_ignore_digit),
> >         DIM(SORT_DSO, "dso", sort_dso),
> >         DIM(SORT_SYM, "symbol", sort_sym),
> >         DIM(SORT_PARENT, "parent", sort_parent),
> > @@ -3577,7 +3666,7 @@ static int __sort_dimension__update(struct sort_dimension *sd,
> >                 list->socket = 1;
> >         } else if (sd->entry == &sort_thread) {
> >                 list->thread = 1;
> > -       } else if (sd->entry == &sort_comm) {
> > +       } else if (sd->entry == &sort_comm || sd->entry == &sort_comm_ignore_digit) {
> >                 list->comm = 1;
> >         } else if (sd->entry == &sort_type_offset) {
> >                 symbol_conf.annotate_data_member = true;
> > @@ -4040,6 +4129,7 @@ static bool get_elide(int idx, FILE *output)
> >         case HISTC_DSO:
> >                 return __get_elide(symbol_conf.dso_list, "dso", output);
> >         case HISTC_COMM:
> > +       case HISTC_COMM_IGNORE_DIGIT:
> >                 return __get_elide(symbol_conf.comm_list, "comm", output);
> >         default:
> >                 break;
> > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > index d7787958e06b9..6819934b4d48a 100644
> > --- a/tools/perf/util/sort.h
> > +++ b/tools/perf/util/sort.h
> > @@ -43,6 +43,7 @@ enum sort_type {
> >         /* common sort keys */
> >         SORT_PID,
> >         SORT_COMM,
> > +       SORT_COMM_IGNORE_DIGIT,
> >         SORT_DSO,
> >         SORT_SYM,
> >         SORT_PARENT,
> > --
> > 2.47.3
> >
