Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0C3B102F
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812433; cv=pass; b=telH1BDSRtWqOWIDBAFB21tlx4LGjk1Z6UQVc7aEWrlzZQP2mTNRwCVhZO2nToJHTPUE+PLusMj7ld3d9DqknVKpqrun/NABQdro7tiNGnRMqRiY0RlBUJi1FKEPDMvurbK17B3VSHD5Ibi0CgaCQMALazbKeawlsYIJUzZNLYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812433; c=relaxed/simple;
	bh=0/mKzTKzXDJLW4O1uKLs23tNKClV8eGtYB1anMalhIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iT3sIAVp/lLMNAl/K8y1AKrOY/JQWjY8Wl8pZpPzAN3hHRT/PRNgMxJTlSIc3hteK2RvaX3/D4IVhw5vUkKmTQTNe7VMV+CnIqYTE/ct2PHvcv8fNVvBJwUeMFHkzL0r7W77oLhjP7xjYYtjezAyppBTlJBKWVP5CIHr3C8Yxo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMpvqKcW; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMpvqKcW"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-136bb8d7e36so104c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 09:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779812429; cv=none;
        d=google.com; s=arc-20240605;
        b=lupa+a/v3jhVgMFDxxlC0E0pWePEWO5qoicaDn73iaCm8YILQtT5RYSYA5MliQQJtw
         POHULh90Nl4mU25MWDbJASBjx3ro245goQ0e9YYkH9VZ8srfL1WICgXCm7FGq9X+gxyY
         X7ug75K1mD+FYz0H08uKvBdki6XgxoBpghRDgqMuF+72WC/ddvQNrtyPG9M/raUgzYW9
         2inqSpgzMQY1VRLfRcuV7PoruewWhc/fTqL9e7D6ZtLVLc+qRt0QpLwjSUOYcDODVAHn
         d8nEzCP9YWcHRa+I9y+iR3mRFiwyvfuXdtdTYCMiy9GmFg4IREjxohqfy7+EcRQFAR4G
         sqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVezQoVPId89N6U1hN/dAz3rmSHMXYipzbwBM2qXShM=;
        fh=XY48s5vb6FPD1M7YLnoO+vWank+Cc6kWAoctRX4y5hc=;
        b=UfOQgf7nprpvxPoVQdvOr17LSOoZwvHMpW7o19WJEJJdvb0Rb7OhFzPWj+0lh0aqez
         y+PPeJvKcOh77oWLmQ7x97CLA4wQVrFuvawAgZ5wTGuVWG3Oci4qR47joZj0QH2VKOWY
         c9teuupyb5zfQ3xK/nEJMxLybl84jERIRV5WFcaprixKXs3K26o9/GejJvlLfp+Yavfr
         Wv1zbqJ+IlFkbV1DalFHd09WRv6uZUEUyAaiOu+AekGUYZeyLGe6r0qzGYXhPPmc7lp0
         bVhVWW09HIBdKQNYhA2bZE0+8NZ1vaZspvU/Hrw/rIfU10LNQZO7EjEgLg9DDiODJc4U
         WuIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779812429; x=1780417229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVezQoVPId89N6U1hN/dAz3rmSHMXYipzbwBM2qXShM=;
        b=CMpvqKcWlAb+zt+V+tiImnWJXqFvHmJ4WQaGJVpIe/2Lu0CvCPhK/uPkoJCnwqNRPd
         djGhS8YY22kKcjs4SYdm5rL7qXStKgbbCc/8lBfdQnbSDJupYcKHo8ZShhj/ABb3GDeg
         E92Q1Sf3RfxPUkrTg+gfVPcr5rvuwBWPT/HirqgG7J8F/xZ1bkkhe41188Gez0fCwbAy
         Ko0AhN2l8CVMIoWpiTmLmQZ+GI7uELfD5F1rW5Y54+hDSQu9Il4C59fZU8KLDXaos9ux
         /Da8BlyGTXS/AgJwklutppTBSs3EkPwnJREIroRzPUpRM33NjcjGXe67H37CMitecCsw
         Yt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779812429; x=1780417229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SVezQoVPId89N6U1hN/dAz3rmSHMXYipzbwBM2qXShM=;
        b=dH2KTQzndKDc8apXinFRReOg0OJI7PGSwtpFAxS3NKrCLnjyLiQOMM+wAYI40dOFy+
         OlWvGOETVr1g+Dk0HU9ZzbtRjIKtlqvearmri3EXRnJnrdUeoPKHOqRkOVi/ZHDohCM5
         +ha8ArsKvBqAD6iXJh6UNGL5rYnB+OFWQLE883Rk+6lNe/Y8ICGcEPB1TUx+fCxST8kJ
         ooLLrfcgX/LpXyPbs1zHiKHC5YLawwgS0V/hFFYOLChNRCGfoiJZmlmKokK9N8JCzI3q
         F6CuFmoaoI9e57qI8jqdM1H9Mz/O0Tu1VOJXlUunajSTjDNjN8r2nj9RWpzlc/mGa1Aq
         Tubw==
X-Forwarded-Encrypted: i=1; AFNElJ+E1t3jZYmWtH59BbfKwFV8wzcSUNLwWrKeokB/KAFrwYCgSzsxpeZAaaAPvNxgcnX1OAn2AFtNaci57FmY1V+i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrht80gKhaFifx6FXnvxjJvcFrRXg01JDUJ4rZF+ubAFMs1OBh
	j9gnpkbgwImBSlZTng8kgMeOjf/kc+Ph2wB7P67OOfQ+TzaZSrrl7XYa12AssSJbSBdVOCiGPeW
	5okIYw9m/PYK1YcfoWK8OC6DusIbA357MLdgtP8/v
X-Gm-Gg: Acq92OG+U7Md9A1J6YwRRWyoYQlb7eFEN/U1jPndxh28P0scdevp7Ja7/dhT7b5Aqnw
	jrxCD882/PjHbjfVdQnWPg1w0g9mqHzRME9eqcN8A/L4mw1V8CifvAD5qElfsD/w3oODY+zOEqk
	SFtgkh7D9Rl824ZJhx52lDaTLTKOhpMaUeTMH9PZ5ys73MQ+h3pQ9525KvBXlR0KQYUSUSLsSgx
	JQqVWb3+uG2ekn8TqwiAf+DnNM9Xu58ZGeAF9d7LoDuS7VQlAc2riO1No4TpgzG/dE+OxS+5uNJ
	CiEy89A33DSqChbRrytcXaXlEKaPoHYb/iJuhyuc/nC0vy/PTCawhpeOvzg=
X-Received: by 2002:a05:7022:f417:b0:134:a710:ca44 with SMTP id
 a92af1059eb24-1368df91904mr311859c88.18.1779812428254; Tue, 26 May 2026
 09:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
 <CAP-5=fU0pLzo8DGETQD3eWig747sGkwRwNs4AvcgGRQi+FGh4g@mail.gmail.com>
 <CAP-5=fUkOHPJPZ3rT_HdFt8A-nzfGNEeeK76FNc3pEj1a4tzZQ@mail.gmail.com>
 <CAP-5=fXmDViUUkKj1OOzG_DOL6w40kA=CM3xh5edmxqcxL6Suw@mail.gmail.com>
 <CAP-5=fWenmjy+19EL+Yv4NYaS18roFtyeV17VCrn3CD+Hb_Nmg@mail.gmail.com> <ahW_FWy_otS8ufTz@x1>
In-Reply-To: <ahW_FWy_otS8ufTz@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 May 2026 09:20:15 -0700
X-Gm-Features: AVHnY4J-g7JMN6VHpj2aNQxRqJTVQ2av1-IUzn6KSFWdJD7SEYjzF3R7JbUPRUw
Message-ID: <CAP-5=fU3CvXgAgnG0jMhKrRg-_NtS=y74nSh4190To7K4gMWTw@mail.gmail.com>
Subject: Re: Summary of perf-tools-next changes and patches sent to linux-perf-users
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:41=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 25, 2026 at 04:41:18PM -0700, Ian Rogers wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > WEEK: 2026-04-27 to 2026-05-04
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > >>> MERGED PATCHES <<<
> >   None
>
> So, Message-ID is missing, from there I would use b4 that would find the
> latest version, collect tags, etc. This is something I have in my
> alternative script that does the same verification, using semcode to do
> the mailing list queries.

By default, the tool filters anything not in tools/perf, so the output
was empty (git log --after 2026-2026-04-27-05-04 tools/perf). Fwiw, my
antigravity set up isn't using semcode and I'm wary of building up a
dependency on it.

Thanks,
Ian



> - Arnaldo
>
> > >>> ACTIVE & MISSING PATCHES <<<
> >   Series : perf annotate: Fix NULL pointer dereference in loongarch_cal=
l__parse
> >   Author : Jianping Liu <frankljpliu@gmail.com>
> >   Version: v2
> >   Date   : Thu, 23 Apr 2026 10:35:30 +0000 (Latest Activity)
> >   Status : Maintainer work (Review tags present on unapplied patches
> > or cover letter)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260423103530.3938202-1-frankljpliu%40=
gmail.com)
> >   Unapplied Patches (1):
> >     -> [1] [TAGGED] [PATCH v2] perf annotate: Fix NULL pointer
> > dereference in loongarch_call__parse
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260423103530.3938202-1-frank=
ljpliu%40gmail.com/
> >        Sashiko: Pending
> > ----------------------------------------
> >   Series : arm64/hw_breakpoint: reject unaligned watchpoints that
> > would truncate BAS
> >   Author : Breno Leitao <leitao@debian.org>
> >   Version: v1
> >   Date   : Thu, 30 Apr 2026 09:40:10 +0000 (Latest Activity)
> >   Status : Reviewer work (No replies to series)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260430-arm64_bas-v1-1-c6ab2b15aec0%40=
debian.org)
> >   Unapplied Patches (1):
> >     -> [1] [PATCH] arm64/hw_breakpoint: reject unaligned watchpoints
> > that would truncate BAS
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260430-arm64_bas-v1-1-c6ab2b=
15aec0%40debian.org/
> >        Sashiko: Reviewed (No regressions)
> > ----------------------------------------
> >   Series : [next] perf/x86: Avoid multiple
> > -Wflex-array-member-not-at-end warnings
> >   Author : "Gustavo A. R. Silva" <gustavoars@kernel.org>
> >   Version: v1
> >   Date   : Wed, 29 Apr 2026 19:29:18 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Reviewed (https://sashiko.dev/#/patchset/afJcDg1I5ZU5ZkXf%40=
kspp)
> >   Unapplied Patches (1):
> >     -> [1] [PATCH][next] perf/x86: Avoid multiple
> > -Wflex-array-member-not-at-end warnings
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/afJcDg1I5ZU5ZkXf%40kspp/
> >        Sashiko: Reviewed (0 Critical, 0 High, 0 Medium, 1 Low)
> > ----------------------------------------
> >   Series : perf/x86/intel: Fix bugs of auto counter reload sampling
> >   Author : Dapeng Mi <dapeng1.mi@linux.intel.com>
> >   Version: v4
> >   Date   : Thu, 30 Apr 2026 00:25:58 +0000 (Latest Activity)
> >   Status : Reviewer work (No replies to series)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260430002558.712334-1-dapeng1.mi%40li=
nux.intel.com)
> >   Unapplied Patches (1):
> >     -> [5] [Patch v4 5/5] perf/x86/intel: Consolidate
> > MSR_IA32_PERF_CFG_C tracking
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260430002558.712334-6-dapeng=
1.mi%40linux.intel.com/
> >        Sashiko: Reviewed (No regressions)
> >   Applied Patches (4):
> >     -> [1] [Patch v4 1/5] perf/x86/intel: Improve validation and
> > configuration of ACR masks
> >        Commit: 5ad732a56be4 (date: 2026-05-05)
> >     -> [2] [Patch v4 2/5] perf/x86/intel: Always reprogram ACR events
> > to prevent stale masks
> >        Commit: 8ba0b706a485 (date: 2026-05-05)
> >     -> [3] [Patch v4 3/5] perf/x86/intel: Disable PMI for
> > self-reloaded ACR events
> >        Commit: 1271aeccc307 (date: 2026-05-05)
> >     -> [4] [Patch v4 4/5] perf/x86/intel: Enable auto counter reload fo=
r DMR
> >        Commit: aa4384bc8f43 (date: 2026-05-05)
> > ----------------------------------------
> >   Series : perf: Fix missing branch counter information in script and a=
nnotate
> >   Author : Thomas Falcon <thomas.falcon@intel.com>
> >   Version: v2
> >   Date   : Wed, 29 Apr 2026 15:29:17 +0000 (Latest Activity)
> >   Status : Maintainer work (Review tags present on unapplied patches
> > or cover letter)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260429152917.178803-1-thomas.falcon%4=
0intel.com)
> >   Unapplied Patches (2):
> >     -> [1] [TAGGED] [PATCH 1/2 v2] perf script: Fix missing '+'
> > indicator when branch counter reaches upper limit
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260429152917.178803-2-thomas=
.falcon%40intel.com/
> >        Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
> >     -> [2] [TAGGED] [PATCH 2/2 v2] perf annotate: Fix missing branch
> > counter column in TUI mode
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260429152917.178803-3-thomas=
.falcon%40intel.com/
> >        Sashiko: Reviewed (No regressions)
> > ----------------------------------------
> >   Series : perf: add timerfd timeout exit-code handling
> >   Author : Malcom Gilbert <malcomgilbert@gmail.com>
> >   Version: v1
> >   Date   : Sun, 26 Apr 2026 18:28:18 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Failed To Apply
> > (https://sashiko.dev/#/patchset/CAJ_TQUzM%2BJXDy4xo4TgeWBL7f6QA0muLxQ8k=
Ev_0hRw6NqrmZQ%40mail.gmail.com)
> >   Unapplied Patches (1):
> >     -> [1] [PATCH] perf: add timerfd timeout exit-code handling
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/CAJ_TQUzM%2BJXDy4xo4TgeWBL7f6Q=
A0muLxQ8kEv_0hRw6NqrmZQ%40mail.gmail.com/
> >        Sashiko: Not Found
> > ----------------------------------------
> >   Series : tools/perf/tests: Update test_adding_kernel.sh to handle
> > proper debuginfo check
> >   Author : Athira Rajeev <atrajeev@linux.ibm.com>
> >   Version: v3
> >   Date   : Fri, 24 Apr 2026 17:24:35 +0000 (Latest Activity)
> >   Status : Maintainer work (Review tags present on unapplied patches
> > or cover letter)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260424172435.91725-1-atrajeev%40linux=
.ibm.com)
> >   Unapplied Patches (1):
> >     -> [1] [TAGGED] [PATCH V3] tools/perf/tests: Update
> > test_adding_kernel.sh to handle proper debuginfo check
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260424172435.91725-1-atrajee=
v%40linux.ibm.com/
> >        Sashiko: Reviewed (No regressions)
> > ----------------------------------------
> >   Series : perf sched stats: Fix segmentation faults in diff mode
> >   Author : Ian Rogers <irogers@google.com>
> >   Version: v2
> >   Date   : Wed, 29 Apr 2026 17:39:31 +0000 (Latest Activity)
> >   Status : Maintainer work (Review tags present on unapplied patches
> > or cover letter)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260429173931.2700115-1-irogers%40goog=
le.com)
> >   Unapplied Patches (1):
> >     -> [1] [TAGGED] [PATCH v2] perf sched stats: Fix segmentation
> > faults in diff mode
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260429173931.2700115-1-iroge=
rs%40google.com/
> >        Sashiko: Reviewed (0 Critical, 4 High, 1 Medium, 0 Low)
> > ----------------------------------------
> >   Series : perf DWARF: Fix libdw API contract violations and crashes
> >   Author : Ian Rogers <irogers@google.com>
> >   Version: v4
> >   Date   : Sun, 03 May 2026 17:10:32 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Not Found
> >   Unapplied Patches (1):
> >     -> [3] [PATCH v3 3/6] perf libdw: Fix libdw API contract violations
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503003552.1063540-4-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >   Applied Patches (5):
> >     -> [1] [PATCH v3 1/6] perf dwarf-aux: Fix libdw segmentation fault
> > in cu_walk_functions_at
> >        Commit: d37a5467709e (date: 2026-05-05)
> >     -> [2] [PATCH v3 2/6] perf dwarf-aux: Fix libdw API contract violat=
ions
> >        Commit: 17e9b4243e76 (date: 2026-05-05)
> >     -> [4] [PATCH v3 4/6] perf probe-finder: Fix libdw API contract vio=
lations
> >        Commit: 9a2ef19b5f52 (date: 2026-05-05)
> >     -> [5] [PATCH v3 5/6] perf annotate-data: Fix libdw API contract vi=
olations
> >        Commit: 5aa194190005 (date: 2026-05-05)
> >     -> [6] [PATCH v3 6/6] perf debuginfo: Fix libdw API contract violat=
ions
> >        Commit: 31088ccf0312 (date: 2026-05-05)
> > ----------------------------------------
> >   Series : perf stat: Merge CPU maps when merging uncore aliases
> >   Author : Chun-Tse Shao <ctshao@google.com>
> >   Version: v1
> >   Date   : Thu, 16 Apr 2026 20:48:04 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260416204828.1303734-1-ctshao%40googl=
e.com)
> >   Unapplied Patches (1):
> >     -> [1] [PATCH] perf stat: Merge CPU maps when merging uncore aliase=
s
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260416204828.1303734-1-ctsha=
o%40google.com/
> >        Sashiko: Reviewed (0 Critical, 0 High, 2 Medium, 0 Low)
> > ----------------------------------------
> >   Series : perf: Reorganize scripting support
> >   Author : Ian Rogers <irogers@google.com>
> >   Version: v8
> >   Date   : Tue, 28 Apr 2026 07:19:03 +0000 (Latest Activity)
> >   Status : Maintainer work (Review tags present on unapplied patches
> > or cover letter)
> >   Sashiko: Failed To Apply
> > (https://sashiko.dev/#/patchset/20260428071903.1886173-1-irogers%40goog=
le.com)
> >   Unapplied Patches (58):
> >     -> [1] [PATCH v8 01/58] perf arch arm: Sort includes and add
> > missed explicit dependencies
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-2-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [2] [PATCH v8 02/58] perf arch x86: Sort includes and add
> > missed explicit dependencies
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-3-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [3] [PATCH v8 03/58] perf tests: Sort includes and add missed
> > explicit dependencies
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-4-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [4] [PATCH v8 04/58] perf script: Sort includes and add missed
> > explicit dependencies
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-5-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [5] [PATCH v8 05/58] perf util: Sort includes and add missed
> > explicit dependencies
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-6-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [6] [PATCH v8 06/58] perf python: Add missed explicit dependenci=
es
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-7-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [7] [PATCH v8 07/58] perf evsel/evlist: Avoid unnecessary #inclu=
des
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-8-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [8] [TAGGED] [PATCH v8 08/58] perf data: Add open flag
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-9-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [9] [PATCH v8 09/58] perf evlist: Add reference count
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-10-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [10] [PATCH v8 10/58] perf evsel: Add reference count
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-11-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [11] [PATCH v8 11/58] perf evlist: Add reference count checking
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-12-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [12] [PATCH v8 12/58] perf python: Use evsel in sample in pyrf_e=
vent
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-13-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [13] [PATCH v8 13/58] perf python: Add wrapper for perf_data
> > file abstraction
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-14-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [14] [PATCH v8 14/58] perf python: Add python session
> > abstraction wrapping perf's session
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-15-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [15] [PATCH v8 15/58] perf python: Refactor and add accessors
> > to sample event
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-16-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [16] [PATCH v8 16/58] perf python: Add mmap2 event
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-17-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [17] [PATCH v8 17/58] perf python: Add callchain support
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-18-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [18] [PATCH v8 18/58] perf python: Extend API for stat events in=
 python.c
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-19-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [19] [PATCH v8 19/58] perf python: Expose brstack in sample even=
t
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-20-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [20] [PATCH v8 20/58] perf python: Add syscall name/id to
> > convert syscall number and name
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-21-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [21] [PATCH v8 21/58] perf python: Add config file access
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-22-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [22] [PATCH v8 22/58] perf python: Add perf.pyi stubs file
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-23-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [23] [PATCH v8 23/58] perf python: Add LiveSession helper
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-24-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [24] [PATCH v8 24/58] perf python: Move exported-sql-viewer.py
> > and parallel-perf.py to tools/perf/python/
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-25-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [25] [PATCH v8 25/58] perf stat-cpi: Port stat-cpi to use python=
 module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-26-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [26] [PATCH v8 26/58] perf mem-phys-addr: Port mem-phys-addr to
> > use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-27-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [27] [PATCH v8 27/58] perf syscall-counts: Port syscall-counts
> > to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-28-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [28] [PATCH v8 28/58] perf syscall-counts-by-pid: Port
> > syscall-counts-by-pid to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-29-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [29] [PATCH v8 29/58] perf futex-contention: Port
> > futex-contention to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-30-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [30] [PATCH v8 30/58] perf flamegraph: Port flamegraph to use
> > python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-31-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [31] [PATCH v8 31/58] perf gecko: Port gecko to use python modul=
e
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-32-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [32] [PATCH v8 32/58] perf arm-cs-trace-disasm: Port
> > arm-cs-trace-disasm to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-33-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [33] [PATCH v8 33/58] perf check-perf-trace: Port
> > check-perf-trace to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-34-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [34] [PATCH v8 34/58] perf compaction-times: Port
> > compaction-times to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-35-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [35] [PATCH v8 35/58] perf event_analyzing_sample: Port
> > event_analyzing_sample to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-36-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [36] [PATCH v8 36/58] perf export-to-sqlite: Port
> > export-to-sqlite to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-37-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [37] [PATCH v8 37/58] perf export-to-postgresql: Port
> > export-to-postgresql to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-38-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [38] [PATCH v8 38/58] perf failed-syscalls-by-pid: Port
> > failed-syscalls-by-pid to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-39-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [39] [PATCH v8 39/58] perf intel-pt-events: Port
> > intel-pt-events/libxed to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-40-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [40] [PATCH v8 40/58] perf net_dropmonitor: Port
> > net_dropmonitor to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-41-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [41] [PATCH v8 41/58] perf netdev-times: Port netdev-times to
> > use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-42-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [42] [PATCH v8 42/58] perf powerpc-hcalls: Port powerpc-hcalls
> > to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-43-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [43] [PATCH v8 43/58] perf sched-migration: Port
> > sched-migration/SchedGui to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-44-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [44] [PATCH v8 44/58] perf sctop: Port sctop to use python modul=
e
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-45-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [45] [PATCH v8 45/58] perf stackcollapse: Port stackcollapse to
> > use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-46-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [46] [PATCH v8 46/58] perf task-analyzer: Port task-analyzer to
> > use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-47-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [47] [PATCH v8 47/58] perf failed-syscalls: Port
> > failed-syscalls to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-48-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [48] [PATCH v8 48/58] perf rw-by-file: Port rw-by-file to use
> > python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-49-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [49] [PATCH v8 49/58] perf rw-by-pid: Port rw-by-pid to use pyth=
on module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-50-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [50] [PATCH v8 50/58] perf rwtop: Port rwtop to use python modul=
e
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-51-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [51] [PATCH v8 51/58] perf wakeup-latency: Port wakeup-latency
> > to use python module
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-52-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [52] [PATCH v8 52/58] perf test: Migrate Intel PT virtual LBR
> > test to use Python API
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-53-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [53] [PATCH v8 53/58] perf: Remove libperl support, legacy Perl
> > scripts and tests
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-54-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [54] [PATCH v8 54/58] perf: Remove libpython support and legacy
> > Python scripts
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-55-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [55] [PATCH v8 55/58] perf Makefile: Update Python script
> > installation path
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-56-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [56] [PATCH v8 56/58] perf script: Refactor to support
> > standalone scripts and remove legacy features
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-57-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [57] [PATCH v8 57/58] perf Documentation: Update for standalone
> > Python scripts and remove obsolete data
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-58-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [58] [PATCH v8 58/58] perf python: Improve perf script -l descri=
ptions
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260428071903.1886173-59-irog=
ers%40google.com/
> >        Sashiko: Not Found
> > ----------------------------------------
> >   Series : perf symbol/env: ELF machine clean up and lazy idle computat=
ion
> >   Author : Ian Rogers <irogers@google.com>
> >   Version: v9
> >   Date   : Sun, 03 May 2026 00:22:48 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Not Found
> >   Unapplied Patches (18):
> >     -> [1] [PATCH v9 01/18] perf env: Add perf_env__e_machine helper
> > and use in perf_env__arch
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-2-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [2] [PATCH v9 02/18] perf tests topology: Switch env->arch use
> > to env->e_machine
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-3-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [3] [PATCH v9 03/18] perf env, dso, thread: Add _endian
> > variants for e_machine helpers
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-4-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [4] [PATCH v9 04/18] perf capstone: Determine architecture from =
e_machine
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-5-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [5] [PATCH v9 05/18] perf print_insn: Use e_machine for
> > fallback IP length check
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-6-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [6] [PATCH v9 06/18] perf symbol: Avoid use of machine__is
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-7-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [7] [PATCH v9 07/18] perf machine: Use perf_env e_machine
> > rather than arch
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-8-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [8] [PATCH v9 08/18] perf sample-raw: Use perf_env e_machine
> > rather than arch
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-9-iroge=
rs%40google.com/
> >        Sashiko: Not Found
> >     -> [9] [PATCH v9 09/18] perf sort: Use perf_env e_machine rather th=
an arch
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-10-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [10] [PATCH v9 10/18] perf arch common: Use perf_env e_machine
> > rather than arch
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-11-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [11] [PATCH v9 11/18] perf header: In print_pmu_caps use
> > perf_env e_machine
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-12-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [12] [PATCH v9 12/18] perf c2c: Use perf_env e_machine rather th=
an arch
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-13-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [13] [PATCH v9 13/18] perf lock-contention: Use perf_env
> > e_machine rather than arch
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-14-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [14] [PATCH v9 14/18] perf env: Refactor perf_env__arch_strerrno
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-15-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [15] [PATCH v9 15/18] perf env: Remove unused perf_env__raw_arch
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-16-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [16] [PATCH v9 16/18] perf env: Add helper to lazily compute
> > the os_release
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-17-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [17] [PATCH v9 17/18] perf symbol: Add setters for bitfields
> > sharing a byte to avoid concurrent update issues
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-18-irog=
ers%40google.com/
> >        Sashiko: Not Found
> >     -> [18] [PATCH v9 18/18] perf symbol: Lazily compute idle
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260503002248.1040791-19-irog=
ers%40google.com/
> >        Sashiko: Not Found
> > ----------------------------------------
> >   Series : perf arm64: Support data type profiling
> >   Author : Tengda Wu <wutengda@huaweicloud.com>
> >   Version: v2
> >   Date   : Fri, 03 Apr 2026 09:48:00 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Not Found
> >   Unapplied Patches (16):
> >     -> [1] [PATCH v2 01/16] perf llvm: Fix arm64 adrp instruction
> > disassembly mismatch with objdump
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-2-wuten=
gda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [2] [PATCH v2 02/16] perf capstone: Fix arm64 jump/adrp
> > disassembly mismatch with objdump
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-3-wuten=
gda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [3] [PATCH v2 03/16] perf annotate-arm64: Generalize
> > arm64_mov__parse to support standard operands
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-4-wuten=
gda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [4] [PATCH v2 04/16] perf annotate-arm64: Handle load and store
> > instructions
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-5-wuten=
gda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [5] [PATCH v2 05/16] perf annotate: Introduce
> > extract_op_location callback for arch-specific parsing
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-6-wuten=
gda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [6] [PATCH v2 06/16] perf dwarf-regs: Adapt get_dwarf_regnum() f=
or arm64
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-7-wuten=
gda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [7] [PATCH v2 07/16] perf annotate-arm64: Implement
> > extract_op_location() callback
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-8-wuten=
gda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [8] [PATCH v2 08/16] perf annotate-arm64: Enable instruction
> > tracking support
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-9-wuten=
gda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [9] [PATCH v2 09/16] perf annotate-arm64: Support load
> > instruction tracking
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-10-wute=
ngda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [10] [PATCH v2 10/16] perf annotate-arm64: Support store
> > instruction tracking
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-11-wute=
ngda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [11] [PATCH v2 11/16] perf annotate-arm64: Support stack
> > variable tracking
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-12-wute=
ngda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [12] [PATCH v2 12/16] perf annotate-arm64: Support 'mov'
> > instruction tracking
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-13-wute=
ngda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [13] [PATCH v2 13/16] perf annotate-arm64: Support 'add'
> > instruction tracking
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-14-wute=
ngda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [14] [PATCH v2 14/16] perf annotate-arm64: Support 'adrp'
> > instruction to track global variables
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-15-wute=
ngda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [15] [PATCH v2 15/16] perf annotate-arm64: Support per-cpu
> > variable access tracking
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-16-wute=
ngda%40huaweicloud.com/
> >        Sashiko: Not Found
> >     -> [16] [PATCH v2 16/16] perf annotate-arm64: Support 'mrs'
> > instruction to track 'current' pointer
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260403094800.1418825-17-wute=
ngda%40huaweicloud.com/
> >        Sashiko: Not Found
> > ----------------------------------------
> >   Series : perf: qcom: Unify user-visible "Qualcomm" name
> >   Author : Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >   Version: v1
> >   Date   : Mon, 27 Apr 2026 07:00:57 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260427070056.18140-2-krzysztof.kozlow=
ski%40oss.qualcomm.com)
> >   Unapplied Patches (1):
> >     -> [1] [PATCH] perf: qcom: Unify user-visible "Qualcomm" name
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260427070056.18140-2-krzyszt=
of.kozlowski%40oss.qualcomm.com/
> >        Sashiko: Reviewed (No regressions)
> > ----------------------------------------
> >   Series : Two semi-related perf throttling fixes
> >   Author : Calvin Owens <calvin@wbinvd.org>
> >   Version: v2
> >   Date   : Wed, 29 Apr 2026 17:36:11 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/cover.1777483573.git.calvin%40wbinvd.or=
g)
> >   Unapplied Patches (2):
> >     -> [1] [PATCH v2 1/2] perf/x86: Avoid double accounting of PMU NMI =
latencies
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/303ba711a576cc016d349a13254823=
7601d8b7b8.1777483573.git.calvin%40wbinvd.org/
> >        Sashiko: Reviewed (No regressions)
> >     -> [2] [PATCH v2 2/2] perf: Don't throttle based on NMI watchdog ev=
ents
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/33d87384aa5f96af76949d13994767=
79dd4f4fce.1777483573.git.calvin%40wbinvd.org/
> >        Sashiko: Reviewed (0 Critical, 3 High, 0 Medium, 0 Low)
> > ----------------------------------------
> >   Series : tools/perf/sched: Update process names of processes in
> > zombie state for both -s and -S options
> >   Author : Athira Rajeev <atrajeev@linux.ibm.com>
> >   Version: v1
> >   Date   : Sun, 26 Apr 2026 09:39:30 +0000 (Latest Activity)
> >   Status : Maintainer work (Review tags present on unapplied patches
> > or cover letter)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260426093930.47809-1-atrajeev%40linux=
.ibm.com)
> >   Unapplied Patches (1):
> >     -> [1] [TAGGED] [PATCH] tools/perf/sched: Update process names of
> > processes in zombie state for both -s and -S options
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260426093930.47809-1-atrajee=
v%40linux.ibm.com/
> >        Sashiko: Reviewed (No regressions)
> > ----------------------------------------
> >   Series : mm/madvise: preserve uprobe breakpoints across MADV_DONTNEED
> >   Author : Darko Tominac <dtominac@cisco.com>
> >   Version: v1
> >   Date   : Wed, 29 Apr 2026 13:15:18 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260429131522.4049054-1-dtominac%40cis=
co.com)
> >   Unapplied Patches (1):
> >     -> [1] [PATCH] mm/madvise: preserve uprobe breakpoints across MADV_=
DONTNEED
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260429131522.4049054-1-dtomi=
nac%40cisco.com/
> >        Sashiko: Reviewed (0 Critical, 3 High, 0 Medium, 0 Low)
> > ----------------------------------------
> >   Series : arm64: perf: Skip device memory during user callchain unwind=
ing
> >   Author : Fredrik Markstrom <fredrik.markstrom@est.tech>
> >   Version: v2
> >   Date   : Thu, 30 Apr 2026 10:55:15 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260430-master-with-pfix-v3-v2-0-bd526=
ec04a75%40est.tech)
> >   Unapplied Patches (3):
> >     -> [1] [PATCH v2 1/3] arm64: perf: Skip device memory during user
> > callchain unwinding
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260430-master-with-pfix-v3-v=
2-1-bd526ec04a75%40est.tech/
> >        Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
> >     -> [2] [PATCH v2 2/3] DO NOT MERGE: arm64: perf: Add skip_vmio
> > parameter to control device memory callchain guard
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260430-master-with-pfix-v3-v=
2-2-bd526ec04a75%40est.tech/
> >        Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
> >     -> [3] [PATCH v2 3/3] DO NOT MERGE: selftests: perf_events: Add
> > device memory callchain unwinding test
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260430-master-with-pfix-v3-v=
2-3-bd526ec04a75%40est.tech/
> >        Sashiko: Reviewed (0 Critical, 0 High, 4 Medium, 0 Low)
> > ----------------------------------------
> >   Series : perf/core: Fix sampling period inconsistency across CPU migr=
ation
> >   Author : Minwoo Ahn <mwahn402@gmail.com>
> >   Version: v4
> >   Date   : Wed, 29 Apr 2026 09:51:34 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260429095134.10049-1-mwahn402%40gmail=
.com)
> >   Unapplied Patches (1):
> >     -> [1] [PATCH v4] perf/core: Fix sampling period inconsistency
> > across CPU migration
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260429095134.10049-1-mwahn40=
2%40gmail.com/
> >        Sashiko: Reviewed (0 Critical, 1 High, 2 Medium, 0 Low)
> > ----------------------------------------
> >   Series : perf tools: Ensure event leader stays at head of evlist afte=
r sorting
> >   Author : Chun-Tse Shao <ctshao@google.com>
> >   Version: v2
> >   Date   : Fri, 01 May 2026 22:33:47 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260501223413.1001483-1-ctshao%40googl=
e.com)
> >   Unapplied Patches (1):
> >     -> [1] [PATCH v2] perf tools: Ensure event leader stays at head of
> > evlist after sorting
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260501223413.1001483-1-ctsha=
o%40google.com/
> >        Sashiko: Reviewed (No regressions)
> > ----------------------------------------
> >   Series : perf stat: Check aliases in should_skip_zero_counter
> >   Author : Chun-Tse Shao <ctshao@google.com>
> >   Version: v1
> >   Date   : Fri, 01 May 2026 18:11:05 +0000 (Latest Activity)
> >   Status : Patch author work (Feedback present in series, but no releva=
nt tags)
> >   Sashiko: Reviewed
> > (https://sashiko.dev/#/patchset/20260501181129.938256-1-ctshao%40google=
.com)
> >   Unapplied Patches (1):
> >     -> [1] [PATCH] perf stat: Check aliases in should_skip_zero_counter
> >        Link   :
> > https://lore.kernel.org/linux-perf-users/20260501181129.938256-1-ctshao=
%40google.com/
> >        Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
> > ----------------------------------------
