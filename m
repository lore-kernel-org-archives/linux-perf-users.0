Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85436921E
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485599; cv=pass; b=qce8NtV5hk41XW2TqYDNddwSGGu5CkaAxjCYksKEncB5Y3sNoLEwHCdYPR4I3hPtryoK7e0eBjit09gkOU+npQM1AYsWF/A+CrB3uO9Xh6OjlFhguaDffwv06H4151Sdpa9aNC5KNMoMLmIb7HACwmoWYmTb9VbK+eAJ8lg9spg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485599; c=relaxed/simple;
	bh=2AjdzpxAKMY+DZXtK7nWlcNW9hZug13PFOCYueZXPAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GN7lOVuQMcMNpvwkJRcrUItfHdW1fetBG1I6jFhggrX3ajqz9miv6crXfrDVsG6FFu7d2S6MUITH2tnwHsYk5JkNNkW0t5wK4B22uvEIe+fXE/7ocR18GknWk5+dpCRZSlCEwzozV7X3mpx1Rw7F6o+BZ9lLDxzPadfAH5ZNsVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nesw7adW; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nesw7adW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b46da8c48eso125ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 14:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779485597; cv=none;
        d=google.com; s=arc-20240605;
        b=A0QYmFkQ9lPPyFG/6tF9Z4I06d+mCOyz8rDH2IzbTA7QN98x7snboUDCW8F3oojYSK
         xHJJDwY91QV0xSK4WdsDH03qqX1c3atfYpJUzxjbVmXZEmVQ1X3dBidbMQzbdf1LNUZf
         E73V7186VFR557pC/pbI1JiNB9noTwAeJ52345FcS2v7L5xqT0bnIEVMHbOdYDS/ReKI
         Ezfea5P5w1C9KMK4oSAlnLumUB5arxZRyX20lhGbQHrNfBJa2STqMh31nX+s+gM5P9hd
         fyfyncMDfiK4PXIMi0hsIQgnUibTyXhlySuzlOL4Z+jo9fH8MR9s/5LmymzzRS2J6dmg
         YsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dypU3mzFG+rIC5+ywKdIEwUMZT8kXgud3j+deLjSqpk=;
        fh=zRxl2ye5nqnJfP+YzWqCDrbENjhChj+771dUpAb4f7Y=;
        b=KuWVuSywooeIxq8GTyS+O10d78xelXP9bAddsCxRl4olFrqxch8vyhbr6aLc++xkqT
         wIlZeJRRbacAAcysfDkWyc+5wxnkPVa9drjpQD9e/CUV+qEDGs8hWnOiNuEsLJ7KKopf
         D9YqWo7YzlX8TG3QdUET3O/Hdf3uPnq3IzUG0p1yAvYDlFlTGQBnjHbZ/9xf0u31j6cy
         Yuxi94wPAmrJTdS8B9tqlDb4TJPBlfu1rLUJTz+f70DA5lMK7KVbS8aCQFkDQVQrIrsA
         VWL2GRsDOdIljQbQMHHb1NUiTbizVRRQ4mecaR7UT0iTTcIzYatcp7/BEv2N9KEZ06H5
         zSMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779485597; x=1780090397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dypU3mzFG+rIC5+ywKdIEwUMZT8kXgud3j+deLjSqpk=;
        b=Nesw7adW2UxfKSRwZUPVF54NuRSwfAj2gq+OcTWuyMOy5rR02Qj2sJoknD3mdwGfls
         50WEEIAvyTI+Nt26+uaobojERSFYeuxETN7K2niCrbF1op7Gah59OXJFL3aU13cp1CfF
         m+js3D+9ozU6TeHAsPGyQClFLaVBG8DVbS9lTSCPSSB1kP1CJlXYJB3UmkK0GXS/QQnJ
         bRU7/edKttnifNeaBt6f2NI21nLxUHIzVufsqXbEFShrQdJEVMgUuyYaxmQ9xEnMOIfw
         RIYimeh7junzSqJD+gIbftyMR2FJFTSOkwc0jWLNgZ84AP2eD9hYzAk+TQQmOXJxZLw4
         Kd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485597; x=1780090397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dypU3mzFG+rIC5+ywKdIEwUMZT8kXgud3j+deLjSqpk=;
        b=DrU6pAsX3wOqxe+8dZZ1QRSVpNot6wTB2lLayfW/wEc3pGh5qm+OewUa6fS/jWpXp/
         fxdbUk5RayfQR5c4qojTZtykARd0orixitrpuWi2ENRiVeJ6qnedNq0uQFADGHP0UrDo
         Uc9yY6069FsSDUp3dDW6TdQSBSmVvW5A0DQ5tY1yikFeyj5EipJcdWtaXEFKtbAUc3DW
         OF3SCr2rftLA4fGOBQKdxnjaV6cnRDEXbbJmWpAxqRcdejKhUXu+4tMnOvknWcoUWjSW
         EI5gWk/EV6SGl0FBHpq5gGdl/ufR3iJP/QmXJHAv4eoXQLwHk95gbZdBfryKCyvGoKOx
         pWyw==
X-Forwarded-Encrypted: i=1; AFNElJ8+5OWCB33RK1mwOox0dHMV31N9yBN8mMR6tuM7QybB76cJ07lzprSqOxUNIyF9w5YGkv+l6g/7+R41Ae388nx8@vger.kernel.org
X-Gm-Message-State: AOJu0YzSlkQeIzQt8fdRa0+yANp46wFIMVJN1GOelUtRIt0dAdZi/5j+
	drKa8XPaKSqaXiNV/rbtxZR4m/OuDYf95eTGI3wQooY9HrYQRMuWzX49+cqgSRW8B2G6JM/y22l
	jn+DIqRvFD6GK3On3PmBKdhDZlk1Rt1q//U3Y6CEF
X-Gm-Gg: Acq92OGkKKTG+W5LS8MtU5JjLenTMeQ8g0lLXwbSc+0HITDHV1Fi48lkziFrVizUmau
	r4LKqNi5BWwHTugyPiaMSUf0d8HM737CvZNObfSN+/hJ5/Ux52dM7Ewg4L8NMY7StuYkKycJIFV
	4vC3U6BUozIsT3HqIqK9wBZ8IN3gPl9hw/oFHj5CoennefVjZ6iyQfvK3ThZnvfltlyW2LbeXFx
	OIasm+/nfQzOEsxUjCmu/vnDFmpF0RI5VXuzKG6zfSw3X/oqTpwpMCNGWX9f+B1bR9B3UAmzqeZ
	hLWO9BrPZpNl09CvOz4RgpuL/5R6KfiXKm/VelX5sC8bQgrN
X-Received: by 2002:a17:903:181:b0:2bd:907:2ce5 with SMTP id
 d9443c01a7336-2bec11cafa0mr205745ad.7.1779485596692; Fri, 22 May 2026
 14:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521072429.1283423-1-irogers@google.com>
In-Reply-To: <20260521072429.1283423-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 May 2026 14:33:05 -0700
X-Gm-Features: AVHnY4LNrJhK02CmhfTQOhoECou3gvmQ72G3IS5DT6hTJEe_rfVTOVwmqarOOZQ
Message-ID: <CAP-5=fV+H3fNnOSYzPoJkdC79DpVOzk2RzLcctYOLjcz81EdBA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] perf: Fix kwork memory sanitization and libunwind
 test builds
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	James Clark <james.clark@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 12:24=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> The combination of the libunwind refactoring and build system changes
> exposed a build-test regression for the libunwind build using a cached
> feature dump. Re-send kwork fixes [1] moving a definition to kwork.h
> to avoid breaking no libbpf builds.
>
> 1. Build Fix for libunwind:
>    "make feature-dump" runs without LIBUNWIND=3D1, skipping the setup of
>    libunwind LDFLAGS. When Makefile.feature is included to generate the
>    cached FEATURE-DUMP, the local test-libunwind.bin compiles without
>    arch-specific link flags (-lunwind-x86_64) and fails, caching a false
>    negative ("feature-libunwind=3D0"). Later builds (such as make_libunwi=
nd_O
>    reusing the dump) compile the unwinder based on CONFIG_LIBUNWIND (remo=
te)
>    but disable HAVE_LIBUNWIND_SUPPORT (local), breaking compilation due t=
o
>    missing maps__e_machine declarations in maps.h. Fixed by unconditional=
ly
>    setting up libunwind feature build flags in Makefile.config.
>
> 2. kwork ASAN Double-Free & Leaks:
>    - Solves double-free in the record command argument array due to
>      parse_options mutation, by preserving original pointers in a calloc'=
ed
>      to_free buffer.
>    - Ensures kwork_usage string is freed on all exit paths.
>
> 3. kwork Unified Memory Lifecycle:
>    - Establishes a unified memory ownership model for kwork_work by
>      ensuring work names are dynamically duplicated via strdup() and
>      consistently freed using work_exit() and a central perf_kwork__exit(=
)
>      teardown path.

It would be nice to land these fixes. Thomas reported the kwork crashes in:
https://lore.kernel.org/linux-perf-users/314df838-4c38-4f03-9515-ae1dabd09a=
54@linux.ibm.com/

Thanks,
Ian

> [1] https://lore.kernel.org/linux-perf-users/20260520190538.142018-32-iro=
gers@google.com/
>
> Ian Rogers (3):
>   perf build: Unconditionally set up libunwind feature build flags
>   perf kwork: Fix address sanitizer issues
>   perf kwork: Fix memory management of kwork_work
>
>  tools/perf/Makefile.config  | 103 ++++++++++++------------
>  tools/perf/builtin-kwork.c  | 151 ++++++++++++++++++++++++++++--------
>  tools/perf/util/bpf_kwork.c |  14 +++-
>  tools/perf/util/kwork.h     |   9 +++
>  4 files changed, 188 insertions(+), 89 deletions(-)
>
> --
> 2.54.0.746.g67dd491aae-goog
>
