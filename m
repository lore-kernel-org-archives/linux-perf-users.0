Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B6361DB3
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534040; cv=pass; b=tquJZssOUXYO+0Y7DLLAEvTlqKturK22gZP0yKqZL799JFQlLxyyUivVkACWcqO+MqumdllGR771z467M1ZMEyVWOktYHmK7apQ25ROn3O19Wxl4cr9V7LSzjhlCJNyi2jBOe2K8DX//tRa9Zo57HvqVsEI+jN2Q1Iuq0jTMSMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534040; c=relaxed/simple;
	bh=Nl5dNY1cFkVZ2RntKDaBzrNXqY/YOkidlAmdOaByYTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2S48hB2LTC6HA2c1rzHs4VP1z7pIqkKjJITVD8sPXkLNWMtl62/qB+5Has/vcvh0qe7SjfoqyaYVvE8hDKeyyRT8fuOvhan24nN52o+UAeCcsTSGmwLeDOJ8Dp8ZnoInkSNo4jYUumeoh6qvAqrZxXMOr7ExUR8+YsIAaa49zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+QOt8xS; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+QOt8xS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a76b39587aso85675ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 09:13:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769534039; cv=none;
        d=google.com; s=arc-20240605;
        b=N9Yg4x6SJ38uk6rtiKLPEe+fqRu4RW2BnjH86nBHqbHMMK6fk+wHozpVSCWWe61c10
         CLJnqI3RukFG/t8/DokxqcFvojEfpjEgA2Aiag5OUDxwIgdKmcZBvQ6XYRsW1FZu0pR8
         iXbhH+z1MGwueywe9XdEc+bIV5Btc+uFgkZq9LQ4jouoxur11Cyupom4e+y01dt2T40t
         JDIWLAmii3RC1FsCSNp8GjtxtDSvhddunLjI1XpzBEwkHIqAt53OdW/mNrMAg7zU29Hc
         8cH2Fphqof2ICMVuAkaOnehCt1biZMFivQx09Nj7dWZhBqSqN2zYWEO2h8QE5baM7Erw
         q4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8QZCb9rl/Q2Ie0D81W18xkCOaqvsjlOrwxyB14TTQLg=;
        fh=F5NUFSS3W1mGgJ5V+Zsn5MLzde9ZkGiSU94FID+hPiA=;
        b=DJOENf9jsVzwT0/bEt75gz4S7qit2d0CfAXyhU2eIkx1VaErPE+eE2a1rTIowk7VNY
         fExTEcaoVQRDai84+bfaOMBzrqhZDXpu6nCYG4xt3/Qnpc9EZVT3lxj6yhVuMIYnk2WV
         eYXoXlLUKNB9FA4H5ETDXC0paJpdFv6E0wxSJIbYN/11JRbh7T+V94KD1VkHW4K4ANNK
         FXuvmuzSIbBzxKvCPy2oKB/MojS5bfoP5/zrKp8IKUwbqB7kiYuAW0vPb1TQA6cFIMfy
         2GlDZoqOMI6edzrlLflz73wocP0RM9OUFVshzkk4uw/SVYxZXAi52zxmsxT1sWlALepX
         1xOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769534039; x=1770138839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QZCb9rl/Q2Ie0D81W18xkCOaqvsjlOrwxyB14TTQLg=;
        b=P+QOt8xSk9XsK7+4tEFS73XkV3xKSJlhF5DOCthiV5qKuaHe8v7Qic2fDIu4GiJyOE
         mRielFzgg69plwm5N5Ua3YiUBl1sSv4RYl6OcXZECFbz8JGOyJyVMFy8I4YzZBe3aAuW
         CG4LIcSQsSCSSb8hNdJHhz2elEgmf3QssNSEWMQYFDWgEXMIeCqMT8maCKxI2KQ68XOz
         TEyZ9jaU2fhapH0bVplpGzhHEQgSF8TWqJRqfZSzw1DfxsHeYFgzjq13oWRTWWoWWAiG
         VYpcxPr4E1IvbDQE3I+U28l9D6zPMYZH/6tazTlW7TIH+hNvezxTPUNllXTAb3TalamQ
         oPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769534039; x=1770138839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8QZCb9rl/Q2Ie0D81W18xkCOaqvsjlOrwxyB14TTQLg=;
        b=CBCB7TB5h7mEQV2++BvFtAgEbSmScGz/bV7D+gI/N9PiqjdLhMtxVv6LDBBgJ1yJUt
         tJb9XmYCnH92kSbFu4IJMd3DCNZoGF4UKXuvh95Sc+XOMtpi2zuf1wCT+D2wCnAuDuZh
         hbvVjhYaRQKbT6GFHjBl/B5tbk6s+Ue1+iUKuWQ/WjzwVD4lWEHca68CLUv5ITWeaHau
         an0ZK3PORUpTgcTQopEHSzL+ayOCQQunnZs/rHghJ/gDUwxWgMjaBpDCrNJINXV2Vaya
         +GHHtg+h+8feWBKPH3mEe5BfJF04QD2WHm0Y3iWVH1zUVfIWbP+M2ccVfP95c/8sm5zg
         jhyA==
X-Forwarded-Encrypted: i=1; AJvYcCUi4AmWQL+tYtHYm/i1xibcHaz8IGYOcyc6W+7iQqtp6GrDUw9KZkU7w/Zr/K/P4yyG/3Am9fvP3159ve61AX1m@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DKVhvxXdjU8cTPN1idmOr8gaouUk9cUBmUZfETVcREPJQHSe
	i69/2vpjaZSZ122JOdjTaZVQMWmn1EuQ+I47u9++KqvchVoH+ceAsKGkAN1QXghyxfXzbcbGY8C
	vkRLWKl41TDOAuTFcJtOnp+OgQuXaCrKOIg4o0GX4
X-Gm-Gg: AZuq6aJgRMFFeKowiUSERw81qEIofaxvLMw7Gi4SaxqK5b1lLgKUHgEstVUJW2dII31
	WldiJd41bWo6TRrMdlHCXzQOsdrlD9k+KYNoH00mJ05+dE8oJ7jWS00N00KNin4boW5xkik+r+T
	/tJOyhn/8Dwqg/08wrZjY3JfYdeijg/FXYvJwa1/1mxWT7joCnhNZ874F2owEjsBbqHwpEamRu3
	ukTzS+wZn5kSVaf93D1N2D1P9NiZspL15Mz2qMvQXTuxzaLvlC1w5Vi/YBKlpmVY93phiKVlcXX
	3xi+GDTRMoFnT6kWI8Qb6+F2
X-Received: by 2002:a17:902:7b94:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2a870b37c3emr1466955ad.15.1769534038143; Tue, 27 Jan 2026
 09:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120090522.1193981-1-qzhao@redhat.com> <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
 <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
 <72bc7c74-a2da-4cdc-b647-1c9e93388c4b@linaro.org> <5122bbaa-7126-455b-97e5-8c998c865961@linaro.org>
 <CAP-5=fXXg=5EvMFm9Jbe+Y81UFcuGYtEZAP86gmXzvbV1=_SQA@mail.gmail.com> <26a8d557-41a2-4b8f-826f-ed795b13264f@linaro.org>
In-Reply-To: <26a8d557-41a2-4b8f-826f-ed795b13264f@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Jan 2026 09:13:46 -0800
X-Gm-Features: AZwV_Qimc-1qwglVHXKIiLQhr9oqiLZoO6Ms029iuhm5_-pvduGJawv3iw_LxNE
Message-ID: <CAP-5=fW1CMwrsZ7vy46Dyv-dm_p1X6TMVwoEPEGxcDwaqiZw5w@mail.gmail.com>
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
To: James Clark <james.clark@linaro.org>, Qiao Zhao <qzhao@redhat.com>
Cc: Leo Yan <leo.yan@linux.dev>, namhyung@kernel.org, mpetlan@redhat.com, 
	acme@kernel.org, linux-perf-users@vger.kernel.org, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 3:02=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
> On 26/01/2026 5:24 pm, Ian Rogers wrote:
> > On Mon, Jan 26, 2026 at 3:40=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >> On 26/01/2026 11:21 am, James Clark wrote:
> >>> On 23/01/2026 6:01 am, Ian Rogers wrote:
> >>>> On Thu, Jan 22, 2026 at 7:11=E2=80=AFPM Qiao Zhao <qzhao@redhat.com>=
 wrote:
> >>>>>
> >>>>> Hi Kim, Ian,
> >>>>>
> >>>>> Do you mind reviewing this change?
> > [snip]
> >>>> Hi Qiao,
> >>>>
> >>>> It sounds like the ARM behavior is divergent from the Intel behavior=
,
> >>>> but that said Intel hybrid rdpmc is known to be problematic. There's=
 a
> >>>> fix for part of that which will hopefully land [1]. One weird thing =
on
> >>>> Intel hybrid is that the rdpmc permission file within the PMU is kin=
d
> >>>> of "shared" between all core PMUs, so disabling rdpmc on the e-core
> >>>> PMU disables it on the p-core. In one iteration of this test tried t=
o
> >>>> incorporate support for this. Anyway, ARM...
> >>>>
> >>>> So in the test we're doing:
> >>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> >>>> next.git/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n243
> >>>> ```
> >>>> #ifdef __aarch64__
> >>>> .config1 =3D 0x2, /* Request user access */
> >>>> #endif
> >>>> ```
> >>>> So 1 question is why the perf_event_open is succeeding with a reques=
t
> >>>> user access bit set in the config in a system where this is blocked?
> >>>
> >>> That's because sysctl_perf_user_access isn't checked when opening the
> >>> event, only when scheduling it in. I don't think that's a bug, but ju=
st
> >>> how it is. I suppose one benefit is that it allows you to add or revo=
ke
> >>> the permission at run time without recreating events.
> >>>
> >>> The canonical rdpmc example in perf_event.h does say the index should=
 be
> >>> checked before reading the event:
> >>>
> >>>     * index =3D pc->index;
> >>>     * count =3D pc->offset;
> >>>     * if (pc->cap_user_rdpmc && index) {
> >>>     *   width =3D pc->pmc_width;
> >>>     *   pmc =3D rdpmc(index - 1);
> >>>     * }
> >>>
> >>> The version of this test before commit 588d22b40480 ("perf test: Expa=
nd
> >>> user space event reading (rdpmc) tests") treated "supported" and
> >>> "enabled" as things that could exist separately and skipped if the
> >>> system has /proc/sys/kernel/perf_user_access =3D 0:
> >>>
> >>>     $ echo 0 > /proc/sys/kernel/perf_user_access
> >>>     $ perf test -vv "user space counter"
> >>>     ...
> >>>     userspace counter access not enabled
> >>>     4.2: User space counter reading of instructions  : Skip (permissi=
ons)
> >>>     ..
> >>>
> >>> Setting /proc/sys/kernel/perf_user_access makes that version of the t=
est
> >>> and the current version of the test pass. That also aligns with what'=
s
> >>> currently in the libperf test tools/lib/perf/tests/test-evsel.c which
> >>> also checks both supported and enabled separately for a skip.
> >>>
> >>> So it looks like commit 588d22b40480 has added the assumption that
> >>> "supported" must equal "enabled" if rdmpc was asked for, but that's
> >>> probably not right.
> >>>
> >>> I think Qiao's change is ok, except it could probably go a bit furthe=
r
> >>> because we don't need to check pc->cap_user_rdpmc if !rdpmc_supported=
.
> >>> Maybe the original separate "is supported" (pc->cap_user_rdpmc) and "=
is
> >>> enabled" (pc->index) checks are clearer. Each can result in a skip on
> >>> their own.
> >>>
> >>> Thanks
> >>> James
> >>>
> >>
> >> Actually if we check /proc/sys/kernel/perf_user_access in the test we
> >> can keep it strict and assume that "supported" must equal "enabled" as
> >> long as perf_user_access is set. That might be better and keep the tes=
t
> >> useful. Otherwise it can start skipping if the feature breaks.
> >
> > Thanks James, is /proc/sys/kernel/perf_user_access ARM specific? It
> > seems very similar to the rdpmc file. I don't immediately see it on
> > the first x86 I tested on. Checking both the rdpmc and
> > /proc/sys/kernel/perf_user_access sounds like a good solution to the
> > problem to me.
> >
> > Thanks,
> > Ian
> >
>
> Arm and now riscv a well, so if we #ifdef it, it should be for those
> platforms. The discussions about why to do it that way instead of using
> the /sys/devices/cpu/rdpmc file like on x86 seem to be suggesting that
> multiple PMU types would make this less good than a global setting which
> you might want to change for security. Although there isn't much detail
> about pros and cons of consistency vs usability and then setting just
> appeared on version after that. The x86 /rdpmc semantics are default on
> as well which wasn't desired so maybe that was another reason to diverge.
>
> Either way it's there now.

I wonder if we can try to read both files, no need for ifdefs. Looking
at the man page, I see references to rdpmc but not to
perf_user_access:
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man/man2/p=
erf_event_open.2#n3394

The rdpmc file path isn't using the event_source version which is a bug, ie=
:
/sys/devices/cpu/rdpmc
should be:
/sys/bus/event_source/devices/cpu/rdpmc
but that's only true on non-hybrid x86 where the core PMU is cpu.
Actually some paths are fixed:
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man/man2/p=
erf_event_open.2#n3669

Thanks,
Ian

> >>>>
> >>>> I'm not sure on the support for the rdpmc file on ARM but it looks t=
o
> >>>> be wired up:
> >>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> >>>> next.git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n324
> >>>>
> >>>> So in the test where you've changed it we've determined that rdpmc
> >>>> shouldn't be supported but the shared page is saying the
> >>>> cap_uesr_rdpmc is available. So is this an ARM PMU driver bug?
> >>>> I wonder if the setting of cap_user_read:
> >>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> >>>> next.git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n1615
> >>>> should also be testing whether support has been disabled through the
> >>>> rdpmc attribute? Hmm.. but x86 doesn't do that:
> >>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> >>>> next.git/tree/arch/x86/events/core.c?h=3Dperf-tools-next#n2753
> >>>>
> >>>> So given that ARM and x86 look in sync, x86 doesn't have issues I'm
> >>>> aware of, and it certainly looks like a failure inconsistency that t=
he
> >>>> test thinks that user rdpmc support is disabled but the page says
> >>>> otherwise. I could use more details to understand this, like what's
> >>>> the contents of the rdpmc file? In your commit message, is the
> >>>> restricted PMU access the rdpmc file or a different capability? Coul=
d
> >>>> this be a weird hybrid/BIG.little issue like on x86?
> >>>>
> >>>> Thanks,
> >>>> Ian
> >>>>
> >>>> [1] https://lore.kernel.org/lkml/24bc287a-a3e0-45f6-
> >>>> a8f1-20a34e2f9af2@linux.intel.com/
>
