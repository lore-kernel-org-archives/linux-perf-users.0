Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B7354ADF;
	Sun, 19 Oct 2025 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760844677; cv=none; b=ugHGcKcH4ZWIY7Pr3Fo8XsmM7O+HpCa4VNcvOxQC0PJHGPMYN7r0c0EgjOzfvvGquVuJEEsm40AGhtG4oDveAnyaOKQBcXJ6ndRBaTLKjPrne4iBOpvzrhxNOFytM5/1O7VIRtb6DNRXMnDBq7YK+wr25zw+2n2L84GrnvressI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760844677; c=relaxed/simple;
	bh=PbPLlMvxrklVX9l1sAAvi0vcgVaGPNJsD9UiZyuMJ84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRTZSsP5uOLixVcDmyKRi4gIcKTzrndlAVaXUHewsW7sBhUYm50m3cZah48Rap5kIqr6Ky11chjgpfWDt7kp/iNdFuHeGRFKPEvORrSZE3rGSImxSTIcESi1AAetY5l2xrHSFT9vXnX+9KxOG0wgLZkXiCckjWsGolwfyijxATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftIne4Es; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftIne4Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54F6C4CEF9;
	Sun, 19 Oct 2025 03:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760844676;
	bh=PbPLlMvxrklVX9l1sAAvi0vcgVaGPNJsD9UiZyuMJ84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftIne4EseL0ptTn7ujtrOFhW4Zie0D3hb/7cHXDdI2CDe5Wc2gKd2T3l+aUfTa7Zv
	 Hy4o68gvaWxlTpZZWYXYMryaXuHiwmaitjM3FM96n9xnuTe/DYS/uSjdHaRmN5lF/R
	 CfqmEesck441zVCFVQ7klWRl7mIxy5zZy2AglCejT8CkD3fpJARofPbk++EhvrE2ho
	 KvibBcxB5YnUJnaOauUxO1aQX3F3nrYzmswP6l2M0t/wX2gO8PR96v8ZKOgKJA3Z20
	 Yp5/4a/WiAJYPZFBAcLH/hFSyUNsy6ez4TDm6cPu203bB36aM2lRB0blXasXd25dru
	 MwDb/1gGEfE8g==
Date: Sun, 19 Oct 2025 12:31:09 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: "Li, Tianyou" <tianyou.li@intel.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, wangyang.guo@intel.com,
	pan.deng@intel.com, zhiguo.zhou@intel.com, jiebin.sun@intel.com,
	thomas.falcon@intel.com, dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tools annotate: fix a crash when annotate the
 same symbol with 's' and 'T'
Message-ID: <aPRbfdU92XRLR-2N@google.com>
References: <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
 <20251015172017.2115213-1-tianyou.li@intel.com>
 <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
 <db33a977-c712-48b7-9be1-83721b23635f@intel.com>
 <046f1441-bc18-44e0-9bd0-f98a62ebbf9b@linaro.org>
 <9f843a5b-4fa1-4abf-9c4b-1e5433ab9704@intel.com>
 <9f33a736-ad3f-426c-93db-b5acca34e5f1@linaro.org>
 <9dd7ecce-dd4f-47a1-a7ad-bb48da8c21f2@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dd7ecce-dd4f-47a1-a7ad-bb48da8c21f2@intel.com>

Hello,

On Fri, Oct 17, 2025 at 12:04:42AM +0800, Li, Tianyou wrote:
> 
> On 10/16/2025 11:18 PM, James Clark wrote:
> > 
> > 
> > On 16/10/2025 4:04 pm, Li, Tianyou wrote:
> > > 
> > > On 10/16/2025 9:06 PM, James Clark wrote:
> > > > 
> > > > 
> > > > On 16/10/2025 4:36 am, Li, Tianyou wrote:
> > > > > Hi James,
> > > > > 
> > > > > Thanks for your time to review. Please see my comments inlined.
> > > > > 
> > > > > Regards,
> > > > > 
> > > > > Tianyou
> > > > > 
> > > > > On 10/16/2025 1:30 AM, James Clark wrote:
> > > > > > 
> > > > > > 
> > > > > > On 15/10/2025 6:20 pm, Tianyou Li wrote:
> > > > > > > When perf report with annotation for a symbol, press
> > > > > > > 's' and 'T', then exit
> > > > > > > the annotate browser. Once annotate the same symbol,
> > > > > > > the annotate browser
> > > > > > > will crash.
> > > > > > > 
> > > > > > > The browser.arch was required to be correctly updated when data type
> > > > > > > feature was enabled by 'T'. Usually it was
> > > > > > > initialized by symbol__annotate2
> > > > > > > function. If a symbol has already been correctly
> > > > > > > annotated at the first
> > > > > > > time, it should not call the symbol__annotate2
> > > > > > > function again, thus the
> > > > > > > browser.arch will not get initialized. Then at the
> > > > > > > second time to show the
> > > > > > > annotate browser, the data type needs to be
> > > > > > > displayed but the browser.arch
> > > > > > > is empty.
> > > > > > > 
> > > > > > > Stack trace as below:
> > > > > > > 
> > > > > > > Perf: Segmentation fault
> > > > > > > -------- backtrace --------
> > > > > > >      #0 0x55d365 in ui__signal_backtrace setup.c:0
> > > > > > >      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
> > > > > > >      #2 0x570f08 in arch__is perf[570f08]
> > > > > > >      #3 0x562186 in annotate_get_insn_location perf[562186]
> > > > > > >      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
> > > > > > >      #5 0x56476d in annotation_line__write perf[56476d]
> > > > > > >      #6 0x54e2db in annotate_browser__write annotate.c:0
> > > > > > >      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
> > > > > > >      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
> > > > > > >      #9 0x54c03d in __ui_browser__refresh browser.c:0
> > > > > > >      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
> > > > > > >      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
> > > > > > >      #12 0x552293 in do_annotate hists.c:0
> > > > > > >      #13 0x55941c in evsel__hists_browse hists.c:0
> > > > > > >      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
> > > > > > >      #15 0x42ff02 in cmd_report perf[42ff02]
> > > > > > >      #16 0x494008 in run_builtin perf.c:0
> > > > > > >      #17 0x494305 in handle_internal_command perf.c:0
> > > > > > >      #18 0x410547 in main perf[410547]
> > > > > > >      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
> > > > > > >      #20 0x7f5ff1a29680 in
> > > > > > > __libc_start_main@@GLIBC_2.34 libc.so.6[29680]
> > > > > > >      #21 0x410b75 in _start perf[410b75]
> > > > > > > 
> > > > > > > Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key
> > > > > > > to toggle data type display")
> > > > > > > Reviewed-by: James Clark <james.clark@linaro.org>
> > > > > > > Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> > > > > > > ---
> > > > > > >   tools/perf/ui/browsers/annotate.c | 3 +++
> > > > > > >   tools/perf/util/annotate.c        | 2 +-
> > > > > > >   tools/perf/util/annotate.h        | 2 ++
> > > > > > >   3 files changed, 6 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/tools/perf/ui/browsers/annotate.c
> > > > > > > b/tools/perf/ui/ browsers/annotate.c
> > > > > > > index 8fe699f98542..3b27ef1e8490 100644
> > > > > > > --- a/tools/perf/ui/browsers/annotate.c
> > > > > > > +++ b/tools/perf/ui/browsers/annotate.c
> > > > > > > @@ -1161,6 +1161,9 @@ int
> > > > > > > __hist_entry__tui_annotate(struct hist_entry *he,
> > > > > > > struct map_symbol *ms,
> > > > > > >               if (!annotation__has_source(notes))
> > > > > > >                   ui__warning("Annotation has no source code.");
> > > > > > >           }
> > > > > > > +    } else if (evsel__get_arch(evsel, &browser.arch)) {
> > > > > > > +        ui__error("Couldn't get architecture for
> > > > > > > event '%s'", evsel- >name);
> > > > > > > +        return -1;
> > > > > > >       }
> > > > > > 
> > > > > > symbol_annotate() only fails for negative return values
> > > > > > of evsel__get_arch(), but evsel__get_arch() has at least
> > > > > > two positive error return values.
> > > > > > 
> > > > > > If symbol_annotate() is wrong and it should be != 0 like
> > > > > > you have, then maybe symbol_annotate() should be fixed
> > > > > > in another commit in the same patchset as this one.
> > > > > > Otherwise you have two calls to the same thing right
> > > > > > next to each other that handle errors differently.
> > > > > 
> > > > > 
> > > > > Thanks James. I will give a try on handling the error
> > > > > message with symbol__strerror_disassemble. I am conservative
> > > > > to change the code in symbol_annotate, agreed it should be
> > > > > considered in another patch. Would like to focus this
> > > > > particular issue and get it fixed properly. Thanks.
> > > > > 
> > > > > 
> > > > 
> > > > Looks like there was a misunderstanding. I'm not saying that the
> > > > error is _reported_ differently, it's that the condition that
> > > > triggers the error is different.
> > > > 
> > > > symbol__annotate():
> > > > 
> > > >   err = evsel__get_arch(evsel, &arch);
> > > >   if (err < 0)
> > > >       return err;
> > > > 
> > > > You added:
> > > > 
> > > >   if (evsel__get_arch(evsel, &browser.arch))
> > > >      ...
> > > > 
> > > > evsel__get_arch() returns positive error values (and maybe also
> > > > negative?), so "< 0" behaves differently to "!= 0".
> > > > 
> > > > You either have to assume that "< 0" is correct and not change
> > > > it, but then you have to also check the return value in the same
> > > > way. Or if by doing "!= 0" you're implying that
> > > > symbol__annotate() is wrong to do "< 0", then you should fix it
> > > > now to not leave __hist_entry__tui_annotate() doing the same
> > > > thing two different ways at different times.
> > > > 
> > > Thanks James. I looked at the code of symbol__annotate, and noticed
> > > the if (err<0) statement. I did not mean to change the code in
> > > symbol__annotate because I did not understand why it handled the
> > > error code that way. The positive return value of evsel__get_arch
> > > indicates some error happens, eg in arm__annotate_init, so I use the
> > > symbol__strerror_disassemble function to handle both positive and
> > > negative error code.
> > > 
> > > I do agree we should check the error code of evsel__get_arch, but I
> > > am hesitate to touch the code which I am not sure the consequences.
> > > I agree it may deserve another patch but not in this patchset if we
> > > have clear answers on why "<0" is not correct, or we have a case to
> > > break the current code as a evidence. Thanks.
> > > 
> > > 
> > > Regards,
> > > 
> > > Tianyou
> > > 
> > 
> > It may take a little bit of effort to follow the code and look at the
> > git blame to see what happened, but it's really not going to be that
> > hard.
> 
> Truly appreciated for your instant response, and the suggestions about
> 'Fixes' tag, return value handling etc. I do check the git history about the
> code "<0", I still did not quite understand the reason of handling it in
> that way.

Looks like I just overlooked the error handling when I factored out the
function.  Please feel free to update symbol__annotate() to check != 0.

> 
> 
> > 
> > You're basically suggesting to add code that (when expanded) does this:
> > 
> >   if (first_run) {
> >      if (do_important_thing() < 0)
> >         return err;
> >   } else { // second run
> >      if (do_important_thing() != 0)
> >         return err;
> >   }
> > 
> > It's not going to help anyone who looks at it in the future. It's going
> > to make future refactors of evsel__get_arch() more difficult, and
> > without knowing why it's like that, it's possibly introducing another
> > bug.
> > 
> 
> I am suggesting to focus on the 'else' part. If that part of code is
> correct, then we might need to consider another patch for the "<0" code. I
> am eager for the answer as well.
> 
> 
> > It surely has to be consistent otherwise it doesn't make sense. And if
> > you sent a patch that did "< 0" I would still say "but it can return
> > positive errors, so the new code isn't right".
> > I did suggest in the beginning to not check the error at all and add a
> > comment saying it must succeed at that point because it's already done
> > once before, but that's not very defensive and it doesn't fix the other
> > possible bug.
> > 
> 
> Yes. I am not so sure 'must succeed' could be a right assumption, or for
> safety it's better to check the error code.

Agreed.  Anyway I can confirm that this patch fixed the crash.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
