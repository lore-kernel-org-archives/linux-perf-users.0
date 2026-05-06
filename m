Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445242F745E
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101581; cv=pass; b=T97hweF/M3C31UHRWjxu1zuMraYDit2XNbDSv0DpHSkCAB7Q7vq+ecl0IpjRUeLu1+jJNMSbD392iqFT16AH02lfJmw4bu76BJWxQrWGOPDOjA/9Se3kIN5B5nDpqJO3gdApDrchlM2pa23Jgo0w//L4SBg0e5rGcVTEfHVJY1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101581; c=relaxed/simple;
	bh=tDLsqs0PpIo0PLsBBIXeYM5UVwCevFcD2YFw2+54qpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDVMtsxbLb2X7nEmV7HcrYlvXfyLSZtqk/6bJ1O5orifTGQA1iDwcCynmkNCrwte/B7uxeSYNUvmfIYIDltL71izChSkcHwfusF1KL2/fdUs5VN0Nk+Lw9LZKce5Dwol6MPFbd0uTJ2SpSfUWcrnUg7SYK5ogi7uFPktzI9w8Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GXM7bIQn; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXM7bIQn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b46da8c48eso13315ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 May 2026 14:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778101580; cv=none;
        d=google.com; s=arc-20240605;
        b=BXW9jbgg4nZVrrsGSRqONbQvQQYruXZ+IJ1xD7YMZUeMCjnDfGbjkuaJwf7cx7cGQb
         OuiBVPieHZ5O4DFyX6LvL8W7vkgHVgSopyyioekjoC2BNEJcRMlhdBSmIIhcXCWuMu9N
         fZ9Gy88HQqahY8Pd+zeFEBdma/4j+nvFcsI2KjqgF/l9qpv3+aXqFba7/HkiI3C9GQl/
         zGUcMy6xuioKHop21rEwnA5PPCyp0GPzSM07VjKG/jR+A89Shk6/eVZAVYhmUtvdqDPn
         L+zC3q6LmurrVJwksWanJkLqXPiIGTVKuJcf98x2VJFG2jtVX0DigfyOqRCyCkdZK/yC
         pEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/GWK98/TwzrgToBg80BXySvCTto/fhyfG54hjfA5OPQ=;
        fh=s7sAHd8pVZa+Y9ldqg6ImltXLHdRLKArpkVE7rR4Zvo=;
        b=eqfTgKNN7MLPA403Cnu8m9G8r8/0Yi7oG1mxI/sP7Cyfbu0zSzIGMU90M1mGIoiE7L
         qcEOwpRvtkyvMTsSBnhB6Aqlc8GAuG77GXBr3Lv0cf0S01UUCqb+of8tJhVq6sKC64sf
         VpqFkhpHdI/kmxWSMeawQCxvf2azPYCz08PYVx4TCygsWaBgkOysf5wlZIPf/bgQZvHJ
         EzAeFAUuA6wUN65PFa8V6yjqDl3SyE+dEwpm02UPB+v9IiyofecHX0GdqJpCgy4L8j9N
         qxKbKuuB6ksBHSOdsdm0FgypkorQYO3RItCgWK7adZ0ys/MtDcyzURNDrg7nvvp+iAFg
         x1Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778101580; x=1778706380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GWK98/TwzrgToBg80BXySvCTto/fhyfG54hjfA5OPQ=;
        b=GXM7bIQnzfTvr8a5VLsBj6ELbyE4x7ZVy9IiWSG7e5xqoqxO9sKcWmOa3DZ/KR/Qgs
         Dj0PhTa7DBHc6XMmWQ+Cuw2b0TEIxzRoH39pmLzALPwcg8lV23vVfWaVE5qsDYKbFgqD
         f4plgHOvQeYlW7cD6IvT9KQ4V4kjYNCRKm56hv0Qk0XqnUB9hwD9XCvn24GaJRJb7X1F
         hOkF1JEVG46XfAni9N+QoBAO/ESGlyp9iblY0txderS22XuC02JIRC2JxYDnJgWos1dc
         pAlJZ4uWUGa9yIsPLHDURYvrKNYzodgokYfbH2AbzQbLAglk+oRou/Tal5CJ9h3C9waj
         21jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778101580; x=1778706380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/GWK98/TwzrgToBg80BXySvCTto/fhyfG54hjfA5OPQ=;
        b=MDuYMUSlmrIZgVjyv+G04yF+Cg7o/e/cTR+Rj+sfm8l2vkpHxZcbXHHfd3AjuJ548F
         zhJTgm897gzdVshtubXAlygE10G1vsiCTeABjJq6mJkdaeUNbL7gDfNSHbQUphGPWATF
         d4fJSNsu2bDiJwPaaSdtlmVJsm9lURVnTyUDzPelbPHHwf2tP0Or7cJBbyPtTzHBLDEc
         n4zFn72GySYb2A65wtzBdBVJBX3OG9eJCR0edvHIQZpxwF7KEPPTJk/xMclt1LVp820O
         uKOBot+Sk6/HWtnqfGsYpSyhVmxs4U0B7el2Mo2lVuRNCmHczgYfONgJzbcc5NPhutYe
         g7VA==
X-Forwarded-Encrypted: i=1; AFNElJ8K4trcjx6c2lQVkgVMg9khTmBgaUTFLIU3XWVWnIlupih+gyY59qcp+LyAmzsb1YG/MG3Jg7AMqkFG9JM20UnO@vger.kernel.org
X-Gm-Message-State: AOJu0YxxGUxMsxNsE+5HLkxT5h2E71fj1Ch53fDWiaT3XUhfW7iJ4M7H
	qMSJ/Iq5noKZzEZg8ER5/ehC/qW1yDqYDcjWg7X8/3Vo2EW8/LSQDS2Kh6xlXb+SLUMsET15J3l
	6bSPbXVC7lLZNeAfvmjN7JBd2tFxQJLLwO9qfqdLI
X-Gm-Gg: AeBDieuRMmrmzXKssmlsHhqtqQhiWTJL7x75Ng3C2soUZjZ3hSzyJLk11W4AwG8d4gu
	CbuuLqgM5YM7nJ419lF6rQo6T8zgMBqmrBmrBnpNRds81PjMHbO6m1AQBo2EjTf2E9uBX4x8XHz
	cLdrZCM8LHJztyKInkMYv3Te7wSVp6jJw4vrOHye7G/dzxMvDaqV0NCq/pMuUg4xZK1h5/VuRZD
	eYeaKobp+9Fggs7OkthWkyaldd1KRFO6SND6kVN1nl/E5SrsfWmHLrTvBxGXjrcIGidZQgsGk3B
	Ov2O7XgAFKidYe9P53AEh/QZPXKjhpReW+Nx3hDo2lfnJvus+V97aPtqzMI=
X-Received: by 2002:a17:903:7c8:b0:2ba:3b89:c3a5 with SMTP id
 d9443c01a7336-2bab640d631mr710215ad.12.1778101579220; Wed, 06 May 2026
 14:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
 <adv8Ka16pvgVkm8R@google.com> <CAP-5=fVc-Ac09cnXYPUVcNwzHOqFod0v=-YjjDf_oVHvM7cHDw@mail.gmail.com>
 <ad0cfz-gUKea5bI8@google.com> <CAP-5=fVs9vhofGdgE6MjAY6QND=VvfEmj1j8jz5ytC5ehAwYog@mail.gmail.com>
 <ad1P8ebyCyfKwXH6@google.com> <CAP-5=fWC7JT4mn-JwBpZ6YvUm4qBFp=wOb+bOj8AM79gxHK0_w@mail.gmail.com>
 <ad3VxtQSL8ClGiEQ@google.com> <CAP-5=fXgkKwAOChOY026AEcmqr3Pdk1hhAgR6UoBLZN8mkXV7g@mail.gmail.com>
In-Reply-To: <CAP-5=fXgkKwAOChOY026AEcmqr3Pdk1hhAgR6UoBLZN8mkXV7g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 May 2026 14:06:08 -0700
X-Gm-Features: AVHnY4JAKLo3zcaOoBSJHtf8o7NrJAr27pUBeqK5rKxrHQBwRL-hdt3MZSRa198
Message-ID: <CAP-5=fXZif_z+0caq=9hMB-SowtHEihfbrgD53K33M8oaRg9og@mail.gmail.com>
Subject: Re: [PATCH v10 00/29] perf tool: Add evsel to perf_sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:23=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Apr 13, 2026 at 10:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Mon, Apr 13, 2026 at 01:55:39PM -0700, Ian Rogers wrote:
> > > On Mon, Apr 13, 2026 at 1:20=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > On Mon, Apr 13, 2026 at 09:57:02AM -0700, Ian Rogers wrote:
> > > > > On Mon, Apr 13, 2026 at 9:40=E2=80=AFAM Namhyung Kim <namhyung@ke=
rnel.org> wrote:
> > > > > >
> > > > > > On Sun, Apr 12, 2026 at 05:52:57PM -0700, Ian Rogers wrote:
> > > > > > > On Sun, Apr 12, 2026 at 1:10=E2=80=AFPM Namhyung Kim <namhyun=
g@kernel.org> wrote:
> > > > [SNIP]
> > > > > > > > I've picked the first 23 patches to tmp.perf-tools-next as =
the rest
> > > > > > > > still has some issues.  Also I've touched some commits to e=
ither remove
> > > > > > > > some parts or split them into separate commits.
> > > > > > > >
> > > > > > > > Please take a look.
> > > > > > >
> > > > > > > Hi Namhyung,
> > > > > > >
> > > > > > > thanks for doing this but I've done a similar clean up. To to=
tally
> > > > > > > separate the evsel refactoring from the rest of the changes, =
to fix
> > > > > > > the address sanitizer issues with kwork, etc. I'll incorporat=
e your
> > > > > > > changes and then resend the series.
> > > > > >
> > > > > > Thanks, I'd like to merge what's in the tmp.perf-tools-next unl=
ess
> > > > > > there's a serious mistake.  You can rebase the rest changes on =
top.
> > > > >
> > > > > I'd drop what's in tmp.perf-tools-next. Otherwise we're putting f=
ixes
> > > > > on top of fixes. Looking at v12 the sashiko issues are all minor =
and
> > > > > the progression of the patches is more granular and natural.
> > > >
> > > > The goal is to reduce the amount of work (including review) during =
the
> > > > merge window.  Also I don't think there are many fixes in the tmp
> > > > branch (have you looked at it?).  I think it's ok to add fixes on t=
op
> > > > in this case but I can drop non-conversion patches if you want.
> > >
> > > While I'm glad the patches are landing, since the changes depending o=
n
> > > the refactor haven't been posted and won't make the 7.1 merge window,
> > > I don't think there's a huge rush to land this series. That said, I
> > > think v12 is in a good place regarding both the shape of the patches
> > > and Sashiko happiness.
> >
> > Ok, then I'll drop the whole patches in the tmp.perf-tools-next except
> > for the first one for a typo fix.  The v12 will aim to the 7.2 cycle.
>
> Should I repost this series for perf-tools-next targeting 7.2? A merge
> conflict will occur with the Python and perf script changes that are
> out for review, the conflict is limited only to the Python API.

Ping.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Namhyung
> >
