Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1522425B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448267; cv=pass; b=V7hQQJblwYvW6gYOv6c+K7nMriBPJPjyD4+a2DXPkCojIR4IzY2Xk6nyxiVw6hXXbfyFwvGgQGw840Resir4FzR7rH4nqSjaLVBQxKELjo/kv/EFg0Kd/pbAj73J8hTVw6XdRReqDC7E3cTwNjp+J208MN2rufvVQk06clTsfcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448267; c=relaxed/simple;
	bh=1X3MgT5pX4KiDft8vB+aGGQmJTO6TBBVX+dKtUh7GB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ae5VKv9d7ToCc8seVuYZYGkRmYrC9bNBo0SHlVF0ARa892mfl3MZgX7GfZ8uwccWasgJFUzaWrAjXqbrXETAKWRgC+n2mfM+W1VDYSdIZQjdAFIdOjOAf3hhhZLtSzIiZnLQfbaYIurH1mVMb3sCSoNGvIk29F574APqaNKBowc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPpNs6PR; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPpNs6PR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a35ae38bdfso163115ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 09:24:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769448265; cv=none;
        d=google.com; s=arc-20240605;
        b=VsuIEy2gQvXAjfYNEqaouFq20w84u/+sQ+aKF/bxt3AkuZbndsokGj+fwD2YxXwMjN
         9KBm79q960RkUbmTPNxLTsETzxQxqPJsSeOVARY8yPh6UFQV9VUVF0Mmk3Caf0kLCWQE
         fDCqOaB0/7/VJIuSm69kfO3zzN+ffcBwNwlvSSyo3VUDOMcK+fhfMBgPPuxFUD1ceuIY
         rHevGyVmSQnd3HyfA/3vExU0d7mmlDFZdpFChVZIHk6Vyc7nIbntLJHxK9ZzWwSbNm7G
         9WmlZV5njogtTNmBxeyVvVl5bvMCqJ4e9oH0PR8J/vZAtOa7Yc1F9nhRp6uLQRzSLfbB
         WIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=as0UfII+UZVOKEciP7E7dVK/JpMO8wHCzyH02iSA4Jk=;
        fh=mr7SppUJTpPV3+HSeylQJwn3bNElkrDsXCHR0G2zgME=;
        b=EdpJp2G/Py91oNRFuO1Ia2fzFgXP5Y9fOI9X90kWvU/VI8xQtvW1QcX6QaDhVrSJou
         vcnVah2/E8PY53nE6w1z8MQOw3qPjWa+cZkFGobE8tI/VW8Q1dzD8Jl82OwFprT+vedy
         eG46bCvrWAtsz283aKbFgC/o4Wmxl3u5oRoT4L2FXGHJfSXm4KU6117bVQfWozR2tCsW
         83zD9RJVnFVU70c7jXxqp2hDxZLH6eBE9eH+CMsnvDENQ1M+mTRB7FARemsSWtLJAS05
         w4nqUYSFpO6WH8lpEIxwlOOL9R2GLAWnZ8+6Ar6RrLJquUDxRclqXHeByaQ8hUkunI4g
         IM2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769448265; x=1770053065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as0UfII+UZVOKEciP7E7dVK/JpMO8wHCzyH02iSA4Jk=;
        b=gPpNs6PR3qSGq5evDI9Kfy766JJ59AFhb6lFeHVs3YYvFDPbipKoxiWGlPA0IJ2RM+
         ujtDdzJni+WgcZWqwKYw7oi7VxCosnE7oMiTnGKLoFnJ14rvxr5IFUuCwCLsAvuXWLEt
         DnlkzY0vl8I5daGD6Vx61EnDx+cFABQE2EEZiNrmfBO4IsehqUAD41qApF7nMqO42ZDp
         CsPO5hoUTAwC1nVn/V9wfK9E9Kasf0fx/63QM94H+IWp3CZh8ZQUDktlBvv1v3IrI2ii
         eDBDCUxoX2hv3+aCxDdKfL+2AfeoTsu0wIfl2auTzyp9U5wdYTgU/NO9/yAoLLtHT/eB
         FjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448265; x=1770053065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=as0UfII+UZVOKEciP7E7dVK/JpMO8wHCzyH02iSA4Jk=;
        b=ofFfl5LViRDb95Dx2MxQ2shVNX1Yt6+cz5cYBzKJ39kK4oDiU6brTij3m5Ww/6i6xp
         JqMC2x2GovQCs8yblqpHqy4y3aSBXpEVIR82uymouwJqe3tRlJhmAmHRjkwyr8Rik9jp
         Khw9EC3TkOWxkZ94vUOZ+h6dQoEG5ZviXHvCx/DjsxBNXDeJADC4MEwcqoLlD5p0skXc
         /LEfoZwFAFu11gda+zbOlqt0828H1AnwY5Nekrsc9h6876IW8ZYK9eBHuQ3SacesHu0N
         auLwQ6FZsaRZ0loAb1ijhH6zpLXi4lfOb3Ql+f6Dr1XJ+PE1Lf5uu3CPkCinyCFDaQgK
         mTDA==
X-Forwarded-Encrypted: i=1; AJvYcCWU4QoJ0JUvbBrEkAWC72eChioMqgkAA6s/a/g8cyY20Vkv4DP1O+7L6eKMe83NAV+uKPnjS0vqXekskr+2Jas/@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoUzOGYnf/QR4QgWy4uk08FzKVIe2wHrtCS8wMy1PP/HCAcOZ
	HprBKN4o2BH+8ElGZg1NZY+imn5GZzOeyfWHsp8iXror9VPuUdpJyNWC16QUnnOSXU0yVYtRMnL
	Xzlv769SeRf/bNqOL7NVsU+QtOwwHN525zZzttUAD
X-Gm-Gg: AZuq6aI7MRA04OXxq+2/IzInmkMnR82Rtm6tr3xKnchYMPXSGPW8AdPq9hk3lZ73uSp
	kiVJPr3QxewFulDuhHlKkkI5Kdgo4c47yF5dozGmKU6yCRiiftPx6nowYWyTRoUBR7Y8zC6aBfB
	Zin8NHzYOsxpfN2/80IfTqNf5KoBiMS5nRnrJ/qeW/VdyATkEp9sdSBI4ztAfVEFW429R3zLd87
	eJsLEcDyNcYBPVab7zQxt3YG9pz4fsZeNEj0RcqFUpWsGcRhJgN3VgakLyjUPXaYTM00F7MwnPf
	ryH9/TFkGP9Fxlhfwb/6X7tT+UjVQWF6wsNW
X-Received: by 2002:a17:903:2c0d:b0:2a7:6c4e:5914 with SMTP id
 d9443c01a7336-2a844b042c0mr2639445ad.6.1769448265238; Mon, 26 Jan 2026
 09:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120090522.1193981-1-qzhao@redhat.com> <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
 <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
 <72bc7c74-a2da-4cdc-b647-1c9e93388c4b@linaro.org> <5122bbaa-7126-455b-97e5-8c998c865961@linaro.org>
In-Reply-To: <5122bbaa-7126-455b-97e5-8c998c865961@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Jan 2026 09:24:14 -0800
X-Gm-Features: AZwV_Qg3FKyrCZ028jkcXiaQ2kmOkjB_PjOWb0X7lB0_BcbwNrW8Ivbn50LS2HI
Message-ID: <CAP-5=fXXg=5EvMFm9Jbe+Y81UFcuGYtEZAP86gmXzvbV1=_SQA@mail.gmail.com>
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
To: James Clark <james.clark@linaro.org>
Cc: Qiao Zhao <qzhao@redhat.com>, Leo Yan <leo.yan@linux.dev>, namhyung@kernel.org, 
	mpetlan@redhat.com, acme@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 3:40=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
> On 26/01/2026 11:21 am, James Clark wrote:
> > On 23/01/2026 6:01 am, Ian Rogers wrote:
> >> On Thu, Jan 22, 2026 at 7:11=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> w=
rote:
> >>>
> >>> Hi Kim, Ian,
> >>>
> >>> Do you mind reviewing this change?
[snip]
> >> Hi Qiao,
> >>
> >> It sounds like the ARM behavior is divergent from the Intel behavior,
> >> but that said Intel hybrid rdpmc is known to be problematic. There's a
> >> fix for part of that which will hopefully land [1]. One weird thing on
> >> Intel hybrid is that the rdpmc permission file within the PMU is kind
> >> of "shared" between all core PMUs, so disabling rdpmc on the e-core
> >> PMU disables it on the p-core. In one iteration of this test tried to
> >> incorporate support for this. Anyway, ARM...
> >>
> >> So in the test we're doing:
> >> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> >> next.git/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n243
> >> ```
> >> #ifdef __aarch64__
> >> .config1 =3D 0x2, /* Request user access */
> >> #endif
> >> ```
> >> So 1 question is why the perf_event_open is succeeding with a request
> >> user access bit set in the config in a system where this is blocked?
> >
> > That's because sysctl_perf_user_access isn't checked when opening the
> > event, only when scheduling it in. I don't think that's a bug, but just
> > how it is. I suppose one benefit is that it allows you to add or revoke
> > the permission at run time without recreating events.
> >
> > The canonical rdpmc example in perf_event.h does say the index should b=
e
> > checked before reading the event:
> >
> >    * index =3D pc->index;
> >    * count =3D pc->offset;
> >    * if (pc->cap_user_rdpmc && index) {
> >    *   width =3D pc->pmc_width;
> >    *   pmc =3D rdpmc(index - 1);
> >    * }
> >
> > The version of this test before commit 588d22b40480 ("perf test: Expand
> > user space event reading (rdpmc) tests") treated "supported" and
> > "enabled" as things that could exist separately and skipped if the
> > system has /proc/sys/kernel/perf_user_access =3D 0:
> >
> >    $ echo 0 > /proc/sys/kernel/perf_user_access
> >    $ perf test -vv "user space counter"
> >    ...
> >    userspace counter access not enabled
> >    4.2: User space counter reading of instructions  : Skip (permissions=
)
> >    ..
> >
> > Setting /proc/sys/kernel/perf_user_access makes that version of the tes=
t
> > and the current version of the test pass. That also aligns with what's
> > currently in the libperf test tools/lib/perf/tests/test-evsel.c which
> > also checks both supported and enabled separately for a skip.
> >
> > So it looks like commit 588d22b40480 has added the assumption that
> > "supported" must equal "enabled" if rdmpc was asked for, but that's
> > probably not right.
> >
> > I think Qiao's change is ok, except it could probably go a bit further
> > because we don't need to check pc->cap_user_rdpmc if !rdpmc_supported.
> > Maybe the original separate "is supported" (pc->cap_user_rdpmc) and "is
> > enabled" (pc->index) checks are clearer. Each can result in a skip on
> > their own.
> >
> > Thanks
> > James
> >
>
> Actually if we check /proc/sys/kernel/perf_user_access in the test we
> can keep it strict and assume that "supported" must equal "enabled" as
> long as perf_user_access is set. That might be better and keep the test
> useful. Otherwise it can start skipping if the feature breaks.

Thanks James, is /proc/sys/kernel/perf_user_access ARM specific? It
seems very similar to the rdpmc file. I don't immediately see it on
the first x86 I tested on. Checking both the rdpmc and
/proc/sys/kernel/perf_user_access sounds like a good solution to the
problem to me.

Thanks,
Ian

> >>
> >> I'm not sure on the support for the rdpmc file on ARM but it looks to
> >> be wired up:
> >> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> >> next.git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n324
> >>
> >> So in the test where you've changed it we've determined that rdpmc
> >> shouldn't be supported but the shared page is saying the
> >> cap_uesr_rdpmc is available. So is this an ARM PMU driver bug?
> >> I wonder if the setting of cap_user_read:
> >> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> >> next.git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n1615
> >> should also be testing whether support has been disabled through the
> >> rdpmc attribute? Hmm.. but x86 doesn't do that:
> >> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> >> next.git/tree/arch/x86/events/core.c?h=3Dperf-tools-next#n2753
> >>
> >> So given that ARM and x86 look in sync, x86 doesn't have issues I'm
> >> aware of, and it certainly looks like a failure inconsistency that the
> >> test thinks that user rdpmc support is disabled but the page says
> >> otherwise. I could use more details to understand this, like what's
> >> the contents of the rdpmc file? In your commit message, is the
> >> restricted PMU access the rdpmc file or a different capability? Could
> >> this be a weird hybrid/BIG.little issue like on x86?
> >>
> >> Thanks,
> >> Ian
> >>
> >> [1] https://lore.kernel.org/lkml/24bc287a-a3e0-45f6-
> >> a8f1-20a34e2f9af2@linux.intel.com/
