Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7F48BD53
	for <linux-perf-users@vger.kernel.org>; Tue,  5 May 2026 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998568; cv=pass; b=HYjLazdlT7K8DeczDhES4FS6GsAv6ZoUDs/jnAltDPgxg36pBjWZOG5y7zCn7w4Pwb3aqqnCIMj+x2q/ykB2SuYxQx2hp4Yn+neOaux6AzUPQ9JPueqfov0FdJ3Fz5Rnzks7U6opGQbAyVZHxLc17/CfR8fCPMW93cvETunZC3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998568; c=relaxed/simple;
	bh=grVCO4sqbjrNZAnXaKIn2jjoTKw7E/Z9sphtrrWBl2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKiwv+Bh1YNMzcWyULbnPRS19VgrjtemoAN6k+lX865OqGXFI1Vd85PvecmbIbVH1GUqEUwzTmNRLPrgtUINMzImtkXKYG0WZTlK6356pqSmQklxX5M+l57K3BmqUpJwm6u7mZ3MqKjMHHVLDThYD8mnbXqPgF2ll4WXedoFtBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0GnmK1H; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0GnmK1H"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so245ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 09:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777998566; cv=none;
        d=google.com; s=arc-20240605;
        b=ivyJt4ph4aLICnigH7QrF/IFXJd5fRnW50KuKIFEetgno9py1NEpwaH23ZLPP6biKW
         NL5Q61qtuj/G1HFxc8HHLxUaH8nfkWTQSn+PuFJbyVR53Br+3XmpEKqb9YZQVt4xRNTk
         liH+X6puvltsuL8Vbfy+52co3QggQ2KY7MBSxLVcWikXlPdWRiTkRhvSSzNYj0uOdA4n
         y7NfiCiKmoV875v/wCP9/mqQg90Pp54dr2Ho/nGdPTyX3Gx0fyUqKdKmIVqtkowOG7cE
         TSTuS3rHJexkvKd+wIAaBDoXumg9BZknn+puOxK6dWS83Tmk703uJJ8m9Huhe8b5UTF1
         QFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tejLCdWD+W9Gylz72lzf9BICdmDlquLXg0HsvAcgNg4=;
        fh=f2/vSbXc41yGl2bQ4Yxb0jA3hVYhm4tQnOz+af5seps=;
        b=ePviGZIytPtlAFJcZC5u7bQpmmktx6ACAqt7aerxGXIaXWeuoOFCR7qd7eAa8i/mtL
         BnglpIkGadUPMI4SYIaVZ6M93Kaz0RcJeRMrs8yvRgDPLZ9T3Cu77MNR4iT24287RsbO
         hL0uNRFyg5OFtoSm42aPLxb1KTSsd3jc0j6v8rJ4t0TI/+10DCCoUmKmSE1bBDbFzaTK
         X60rdaHxwaYn0d2uWeuy/VNlTicbqFUKuH8JwjB0gxnxDzTGlMTJmnioriTY3UW5ve3v
         S3Tp6sl1a6wrWOjdOghO9wcYIeBN+w7hcSrv9tp5HFQ7jPghS3OK+3OfRL8KXB4sXmfx
         aBVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777998566; x=1778603366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tejLCdWD+W9Gylz72lzf9BICdmDlquLXg0HsvAcgNg4=;
        b=C0GnmK1HDRx5ODGv4a5/DIMTcVnmWSIwD7OQHo+tHoOI/SlV9gs1eM93a4XSlpDO/9
         Mz6j/tfC7ChaBAV6zE4ka3zBcLnIns+32+RzOe8B/etSI6dwS3CDMS0JRyc9hS1OglpI
         HKEOo2Id1N0oIee84FISY8SBtr8G5RHZ34sLM5ZYEcwu8uHzQrdPVgWPdOYPZU/10Gm0
         vvT6gOIChsGffV6FyzT5cpedtMAT3OMfUUvkxU61pUPj4O07ZQxmbDGc8Ny+hAmStRAn
         uQcU0bHUp/L/Q9N6StA7g/vS2vCoww5UJGLG7WiurOAYuITtDGKXE/civ/UAhKksEA58
         pblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998566; x=1778603366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tejLCdWD+W9Gylz72lzf9BICdmDlquLXg0HsvAcgNg4=;
        b=dNfIbQNf9cfdbrmNMCyJoGxbvEywUqMbrpmfaRnIENv8QlRZFycusrZB13i21liLss
         mJNAL179Sy1P+IV388RXlAiVFc21j5+86ASWefbbe9NDe6M2xDJd8q72VU3XCyeTx8jE
         MeCP+1lCMVVB/i98buFBwcHIhIEPTsGNysvLbZfDCYaBGv4CySv4CayHWmSsQ6bFJgoA
         RqN2s1/zEgre1amfcRw6Qt2Yet8y7S7agyVHO76dLy7jykrk20i7DDGBcYf0z/XD/P6h
         U3zQ4LVoyD7sY0gdPttEVgknkaDrbFtT3VnhRzcxr6qMv9lMWHjRoscUCOniKd94ZuNF
         D/mw==
X-Forwarded-Encrypted: i=1; AFNElJ9nHgxDqF8ld4vZfmdbb9vCBKEL58Mw33dT1V3WMK8dNwfGVD7So3i4Yquk+PnywfkKVslRUba7oABEbZfI0TJq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvib/ZM+b7RiJt2L0NDV/h+1uKqG7q09HbSFy1cfnIu1lGpJA4
	zGNLJy1FrTp5AeRwceXZugTiSxw0IP388TDLqpvUpzrm83IpvOhKiiry3JJOT07uXIthFKrcV+i
	+rFLo0DswrvggtF9wdB0MN+G2dp+V422lUXRulp2S
X-Gm-Gg: AeBDievcxoPSaLOd14jKaoTJVJMug0tGZfGZgFmJNBtirYQ0LEYkzqgWiTgoeBxdqdH
	64DnpRq4XKFg57ox92IICSPylFFOLoF9ZK/HQM14RqZXwKrinLwQAZIZARm5JRUYMZYkhwh9xiG
	PblFVrtJrh4k9uJZ0UcbUF9cWcMHOAIyjrU+Bq03o0FeJHjuXQprfTr0wlLPZGYVs4Ox91eC1Ik
	T+66acC5Nucf/jRrUs+mYK//EcmNr3LAv+sPgDZ1Ex9aPBkskVprAvRXo/KIxy0Zou6xW32rWwq
	hSi+4Rvx/wygnPVop+klwygFYekJNA==
X-Received: by 2002:a17:903:3808:b0:2b0:d1f4:f601 with SMTP id
 d9443c01a7336-2ba531ac243mr3765275ad.15.1777998565184; Tue, 05 May 2026
 09:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
 <afkw4MARqVAYOB2p@google.com>
In-Reply-To: <afkw4MARqVAYOB2p@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 May 2026 09:29:13 -0700
X-Gm-Features: AVHnY4Ih98iOm3wVlv_QA0gDjGnlM0klGx8fFlwKTxlHsy4Vx-_rCj2goOxEuQ4
Message-ID: <CAP-5=fWq1YWg09kaGovUtPaJh9udz5J6rdxL8_tf6N=hA+ewVQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] [PATCH v5 0/9] perf DWARF: Fix libdw API contract
 violations and crashes
To: Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 4:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> Just updated Masami's email address.  Please use it for later.

Thanks Namhyung, I'll make sure in the future. For Masami's benefit
here are the LKML posts:
https://lore.kernel.org/linux-perf-users/afkw4MARqVAYOB2p@google.com/T/#mb8=
87c8aadf50c0371c4cb9273b9a7777591ad99e

The sashiko reviews (the 1 "critical" issue isn't an issue as
mentioned in a separate thread [1]):
https://sashiko.dev/#/patchset/20260504081227.2203848-1-irogers%40google.co=
m

I think the series is ready to land and given that it fixes crashes we
may want to cherry-pick it for 7.1.

Thanks,
Ian

[1] https://lore.kernel.org/linux-perf-users/afkw4MARqVAYOB2p@google.com/T/=
#mc177f9ef695805b013fce3fecbea7d84dfa937fd

> Thanks,
> Namhyung
>
> On Mon, May 04, 2026 at 01:12:18AM -0700, Ian Rogers wrote:
> > This patch series addresses a number of DWARF/libdw error-handling
> > bugs and contract violations, preventing several real Userspace
> > segmentation faults and memory/FD leaks.
> >
> > In v5, the series has been extensively restructured and polished based =
on
> > comprehensive review feedback on v4, focusing on history granularity,
> > bisectability, and defensive styling:
> >
> >  - **Commit Splitting for Review Granularity**: Split the previously la=
rge
> >      libdw contract fix patch into 4 granular commits to cleanly isolat=
e
> >      independent improvements: introducing clear_frames refactoring, fi=
xing
> >      ORDER_CALLER parent update corruption, adding line 0 support, and
> >      consolidating core contract/leak cleanups.
> >
> >  - **Bisectability & Correctness Hardening**:
> >      - Fixed an unused variable compilation failure (-Werror) in the sp=
lit
> >        history to guarantee perfect git bisectability.
> >      - Fixed a line 0 fallback regression to ensure that if an optional=
 call
> >        line is missing but the call file is valid, we fallback to line =
0
> >        to preserve the filename rather than discarding the caller info =
entirely.
> >
> >  - **Style & Robustness Polish**:
> >      - Standardized all newly introduced C++ style (//) comments to
> >        preferred C style (/* ... */) comments.
> >      - Implemented explicit safe string duplication style fix in annota=
te-data.
> >      - Corrected CU DIE propagation context inside probe-finder.
> >      - Enhanced the Patch 2 commit message to explicitly detail the rem=
oval
> >        of strict optional attribute aborts (decf) to clarify review que=
ries.
> >
> >  - **Tags Collected**: Integrated Acked-by tags from Namhyung Kim for P=
atch 1
> >      and Patch 9.
> >
> > v5:
> >  - Restructured series from 6 to 9 patches by splitting the libdw commi=
t.
> >  - Fixed compilation bisectability and DWARF line 0 filename preservati=
on regressions.
> >  - Standardized comment styles and applied safe duplication formatting =
fixes.
> >  - Updated commit messages with detailed optional attribute justificati=
ons.
> >
> > v4:
> >  - Localized and squashed robust error handling, memory/FD cleanup
> >    paths, and safe DWARF printing.
> > https://lore.kernel.org/linux-perf-users/20260503171032.1559338-1-iroge=
rs@google.com/
> >
> > v3:
> >  - Minor formatting fixes.
> > https://lore.kernel.org/linux-perf-users/20260503003552.1063540-1-iroge=
rs@google.com/
> >
> > v2:
> > https://lore.kernel.org/lkml/20260502155656.478642-1-irogers@google.com=
/
> >
> > v1:
> > https://lore.kernel.org/linux-perf-users/20260502064839.282422-1-iroger=
s@google.com/
> >
> > Ian Rogers (9):
> >   perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
> >   perf dwarf-aux: Fix libdw API contract violations
> >   perf srcline: Introduce inline_node__clear_frames()
> >   perf libdw: Fix callchain parent update in ORDER_CALLER mode
> >   perf libdw: Support DWARF line 0 in inline list
> >   perf libdw: Fix libdw API contract violations and memory leaks
> >   perf probe-finder: Fix libdw API contract violations
> >   perf annotate-data: Fix libdw API contract violations
> >   perf debuginfo: Fix libdw API contract violations
> >
> >  tools/perf/util/annotate-data.c |  27 +++++----
> >  tools/perf/util/debuginfo.c     |   9 ++-
> >  tools/perf/util/dwarf-aux.c     |  39 ++++++------
> >  tools/perf/util/dwarf-aux.h     |   5 ++
> >  tools/perf/util/libdw.c         |  72 +++++++++++++++++-----
> >  tools/perf/util/probe-finder.c  | 102 ++++++++++++++++++++------------
> >  tools/perf/util/srcline.c       |   9 ++-
> >  tools/perf/util/srcline.h       |   1 +
> >  8 files changed, 179 insertions(+), 85 deletions(-)
> >
> > --
> > 2.54.0.545.g6539524ca2-goog
> >
