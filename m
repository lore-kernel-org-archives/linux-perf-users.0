Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042022FE575
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764832; cv=pass; b=VZdXy9nUdDetppasnYhgqKpn5lS09fVonc8TQH6R6NyQYY9vs7ZKsBRvW6pp9M9RDra6XrmMx7IhKFIC9ueFIus3aeGAtppzufW49MS5YrNjYeIWc/oYPW6hgWXAceZZqbLTRS1Zp55ZpPVCxC+0AOshUOHuA/u5O2zVssFMsrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764832; c=relaxed/simple;
	bh=JxegEAoD6cH9yM+BzeK5zY1BHi17M+18lCvI/sgUcBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdXbFChAT4QJeXQqwHIRo1llKDAql6RDQB2w72LSb96mYGY+jmIpeQ1KI9IGG7QW0gW3vVOp4HZb0xvdXJNHHeO+HTid+C62bZ37qwM8z10tCWui0CAxNq0KNT0spZuKICjI/3/wJwqFqgV/M2+qXNNe+6yZyI2g0JYIkPv0d8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEoicKyt; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEoicKyt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so365ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 20:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779764830; cv=none;
        d=google.com; s=arc-20240605;
        b=b8NWNA/vT5AvT91wDs/hQbXLHhrGh/zJtho4E83mRQKCbG1G46eSTgFUSPhkfSeUf1
         KEUaL3BruZ/lW/nrh+o/5FCARmBIkgcde/Q2pGTxn2apEEll3krXKygy1ZjRIRWcnqyP
         gQ4PIY82OyBY6xz82Y64bpmKca10hiQfzIw3brZ4gnbTGUFwhoygOu9j45Xzgufsh1tV
         fFBNFc/FMfQoZkpzrEiz6yCt25m2PRNUrGqQG7VfQxWm2evwcebkB09oCv9NHjeem6og
         SgSrssNv/OHge0Ty6b1GswivECzxC19NaCExU1EMqqONWd6AubjgjOFVJnI2pO5Ti8j3
         EeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHvGGTdsOqkhJoAEyNoo3QUdmha9JKeI2beers3/JOA=;
        fh=JcJkPN28YG/jDf1qD6/bZDwLv2Ztf6BQDCymz6W0Uw4=;
        b=bodXgCmuuER2Lgtno438I9JTheZ8ztQO8W5DcacfSiQ2CqLZdZKdJhTLOHKmmRP524
         rnQH3Nz1oF9PHDEg2si0oghQhYk6i/IyJDmeNsRdbcUI7cGf9LNREMNNjRwX/DC+DoFw
         5BA6vPJRKTbQ/tjG7qpMW2U0vzklhzPPAcbSMGXlx4z1bltO4tJZqwoohqv3L/oFsKWZ
         QdyjjVW++Vq5fSl74/uf4PApvhHS++UuIHMafnVPPCMYDttL+U+/4Al9EXu56HYj3Hc7
         MLmQQKWM1jyZT0PWWbYdq0NT/VYtXVvl27Q6+tejmXztyMWpFqJL1phZsQADQzyEoX1p
         TFLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779764830; x=1780369630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHvGGTdsOqkhJoAEyNoo3QUdmha9JKeI2beers3/JOA=;
        b=KEoicKytGIrdsCS4TmoNrHeyXKa5lufWT5ZfM1MC4a+i0g3F9DtoGbJJZjMMNeaJO3
         JhgTxn51AJWZO/uPbAjmPJrCJLb3HPlpQ4+LIwYc4M6gAH7eHxrqKBiLIEtjDT8sLaJC
         sQqlKygLiz5ATrqEWqUskPSo3NHJEFK3enkvidzruOs672/jfzTLptq0d4H34eoPoUgs
         eMrZrcP1ifIg3PA56O0FDCIKNStLdWPE7UhwYRkunP0L+skMDEUV2VI/oOy7PKGfCSwJ
         n9j6dB7bsUpi7sz/d/J+ZTH+EoG6qo8uMiV5boAFpRdx++FMSCBNVuJgSXhJnxOx61tT
         /pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779764830; x=1780369630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHvGGTdsOqkhJoAEyNoo3QUdmha9JKeI2beers3/JOA=;
        b=RXjLdIrXbJ+pKsrSxYEI184f69TvzzN/5jOr+UzwM4fVbS5IRZoHzz6TfPKzjJpMXH
         vm+eFidstCAGn3Uzje2Cweg+mcgPGJdPdvEcWh1sIdgppuLHP7YfGBN6kNzvIhXB4cBE
         AHZDgMZPvT7XrTntqIl/oaih0Tb/yylRkP4BoI69ZL3I6TixRLBUuDODe5xQw8REZH+M
         hwnqSJxesZ0o45CS/zm4dgoF4W3SSDvfsCe5NDKUlAQbeYnb8a3nJCZ0PwrBTILjVUBT
         x+gacGh7/K1CV4P04EWbMU2RlzLkLJ+64YKJl7AVzHRlpj7QprKB5Ksh47iNM1urOVe3
         AO7A==
X-Forwarded-Encrypted: i=1; AFNElJ8IcGhhiTUnDfxOov29F9vcmXjrUcBtNuTbD5lsvw86v1boGJzVNQ/+aCvVPfnzZQJZxJWgQX6LFRCo9mJRXjCv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0OiQEp04Sy/0gHWmyjGW4T4tvpdbt6J/s1lLecvhVzXYyXub
	ORLKmwclmlT0JjxCw11syimKpmzPfgRSzgL4LjfHWog7sLZHuVuFsY8O9rzsCYVxR11wUDZzskd
	oWU6EQo6xZQBPdU49HtYECZV9tgiZEQGoMdZE2HIlu3b8EXjiBQY1ESva8Fk=
X-Gm-Gg: Acq92OH1RVKxOjzPI0gpTfOcpMMwa0vzJwMEshFnsNEcN1rbu+iJDQfCN5XwHX1A1Lk
	sm1Ra/2j5Jk1lOd29mKsTj5Sxmq5TbPZVGK1VXpGAebCfCXym/7JzTKjVBZycGzH3046lusjOWV
	7ea+5uOFi4u90BeAdO30WWytQ5HSTVLIR/wxOh0MixtKOxzYehdcfDshDniXLi3y1oBxXeCxkJ/
	fDWWAiWX6cfnS0x6s5Lh1whGWiEmQs0vH27Y1Bfb0f/tMuv45PrS7o+qhx5i7jqTyg1HHzxakAy
	ADHh25SR7BL6VrPltIQ=
X-Received: by 2002:a17:903:1210:b0:2bc:dc0b:ab29 with SMTP id
 d9443c01a7336-2bebe127843mr4023405ad.0.1779764829398; Mon, 25 May 2026
 20:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
 <ahTn2SnHbe4QHdEo@google.com>
In-Reply-To: <ahTn2SnHbe4QHdEo@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 20:06:58 -0700
X-Gm-Features: AVHnY4KreH7Sy1kh-IR_iGLT8IehppPewNRSaCjOCUv6DFZL7jew355xo6k-1qY
Message-ID: <CAP-5=fVERhArE0NyTUU6Yg57YEJ4793NDVzGUPkARSjMR8c7PQ@mail.gmail.com>
Subject: Re: Summary of perf-tools-next changes and patches sent to linux-perf-users
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 5:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Mon, May 25, 2026 at 04:35:51PM -0700, Ian Rogers wrote:
> > Hi,
> >
> > I've been working on a script [1] to summarize what's been sent to the
> > linux-perf-users mailing list (using nntp) and compare it to what's
> > merged into the perf-tools-next branch (using git). The idea is to
> > make it slightly easier to track down patches that might have been
> > missed. The script shows what has been merged and what's pending, what
> > Sashiko thinks, and whose turn it is to work on the patch (author,
> > reviewer or maintainer) using some naive tag analysis. The output is
> > quite large, so rather than adding it below, I will send the last 4
> > weeks in separate e-mail replies to this message.
>
> Great!  It'd be very helpful for me.  I have two requests.
>
> 1. can you make it not to wrap the long lines?  I guess it may be an
>    email client setting.

Yeah, I sent from gmail. If I'd sent from the command line then
hopefully things wouldn't get wrapped.

> 2. can it show only summary of the series, not whole list of patches?

So the reason for listing the patches is that it better fits my use
case, which likely differs from Arnaldo's and yours. Often times we'll
skip a patch here and there and then I'll get surprised something is
missing. You can see this with Dapeng's series, where 4 of the 5
patches were merged:

  Series : perf/x86/intel: Fix bugs of auto counter reload sampling
  Author : Dapeng Mi <dapeng1.mi@linux.intel.com>
  Version: v4
  Date   : Thu, 30 Apr 2026 00:25:58 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260430002558.712334-1-dapeng1.mi%40linux.=
intel.com)
  Unapplied Patches (1):
    -> [5] [Patch v4 5/5] perf/x86/intel: Consolidate
MSR_IA32_PERF_CFG_C tracking
       Link   :
https://lore.kernel.org/linux-perf-users/20260430002558.712334-6-dapeng1.mi=
%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
  Applied Patches (4):
    -> [1] [Patch v4 1/5] perf/x86/intel: Improve validation and
configuration of ACR masks
       Commit: 5ad732a56be4 (date: 2026-05-05)
    -> [2] [Patch v4 2/5] perf/x86/intel: Always reprogram ACR events
to prevent stale masks
       Commit: 8ba0b706a485 (date: 2026-05-05)
    -> [3] [Patch v4 3/5] perf/x86/intel: Disable PMI for
self-reloaded ACR events
       Commit: 1271aeccc307 (date: 2026-05-05)
    -> [4] [Patch v4 4/5] perf/x86/intel: Enable auto counter reload for DM=
R
       Commit: aa4384bc8f43 (date: 2026-05-05)

or similarly in this series of mine:

  Series : perf DWARF: Fix libdw API contract violations and crashes
  Author : Ian Rogers <irogers@google.com>
  Version: v4
  Date   : Sun, 03 May 2026 17:10:32 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant t=
ags)
  Sashiko: Not Found
  Unapplied Patches (1):
    -> [3] [PATCH v3 3/6] perf libdw: Fix libdw API contract violations
       Link   :
https://lore.kernel.org/linux-perf-users/20260503003552.1063540-4-irogers%4=
0google.com/
       Sashiko: Not Found
  Applied Patches (5):
    -> [1] [PATCH v3 1/6] perf dwarf-aux: Fix libdw segmentation fault
in cu_walk_functions_at
       Commit: d37a5467709e (date: 2026-05-05)
    -> [2] [PATCH v3 2/6] perf dwarf-aux: Fix libdw API contract violations
       Commit: 17e9b4243e76 (date: 2026-05-05)
    -> [4] [PATCH v3 4/6] perf probe-finder: Fix libdw API contract violati=
ons
       Commit: 9a2ef19b5f52 (date: 2026-05-05)
    -> [5] [PATCH v3 5/6] perf annotate-data: Fix libdw API contract violat=
ions
       Commit: 5aa194190005 (date: 2026-05-05)
    -> [6] [PATCH v3 6/6] perf debuginfo: Fix libdw API contract violations
       Commit: 31088ccf0312 (date: 2026-05-05)

The patch flagged as missing in my case was broken apart with
different commit messages, which is why it's being flagged. But in
general it is easy for an individual patch to go missing. If
everything is merged the patch appears in the merged section;
otherwise, there's some action required from the patch author,
reviewers or maintainers. I think the cover message also often misses
other things happening in a series. Hopefully, grouping of the commits
allows you to quickly skip through the verbosity.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > [1] https://github.com/captain5050/ian_tools/blob/main/missing.py
