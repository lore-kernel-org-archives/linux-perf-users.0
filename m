Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D22EC569
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935249; cv=none; b=Q3FWFxf7hBxBoltop6Hjwyn5bA3UDLo3/FgtHfHP3GkcPvS6KwwwFPFM0AERy2slpLl7fZyAiP6FZ+L+VvCMyPuZFmWsPWXvPS7JgLiJhId3dz5t3kl9BQvbCghJDNFKXDlnym9tJH9+t3bc1wiFP9vHQEMxtzrRdMefQlreP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935249; c=relaxed/simple;
	bh=+mRa/gXC23m/hsQPGterNRn+7H5NeLRUuDfytZnsvys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQ91ou0yNa3eCVtnNO/2pDU0mj/+/Q3G7Ru+mqqYeXxZhu3a0RlloYcr3LQKPUVeN1De+Jxm9NtCIDOqMw0ySnCU3nySZoalY0IMjerMlUF3P/9GdJpsinVFmTBOuULiI+lviK3NSNef6WdItj5+9KiCe0En9l2KbMp05VsDgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFmOvXE8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFmOvXE8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2731ff54949so194095ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759935244; x=1760540044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlIwCj/mXH09b2dxNKE7DH/ojQ1NWb3Jc9aHeO0wBL0=;
        b=bFmOvXE89smKH4mrvNzXOTmku1InbJy791MR1W3WSI4w6Ljzzd6y2yPuNMLmmQq5uE
         hYjXec7YFYIj7m89JMWrZOggFRGAF9V/czqwQz1jQL9oQnoAMvqTqdXm62QgBt5Gl680
         GT7L1ULQhRcJlJOPd4s/bmrA6qrGWdm7nZDlayFcA6IeDplOwaGaw06HMMjiL3dnFoWB
         zjujOarTGJC5lpnZvZsXgwVvm3q3igxJJQxo5WvEvpuLtjOvxTesQXdhW9UleTM5cKSR
         tE38LlwJNcDYmPeQ+qBfcXgg1r2/V0M/NtBiO+RTyZkOR89q+ainsO+SSVXNlvN4aTkz
         75yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759935244; x=1760540044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlIwCj/mXH09b2dxNKE7DH/ojQ1NWb3Jc9aHeO0wBL0=;
        b=WwbTNOkN1KaRzT7kcVOYhXcncOL5wZDwgKRykTUSs15i3aUPGesaXS4MB+s+wvaQKM
         vBGfpgz/trNwQ98Zek0nF+aZTpvNNPmWlQhCo8SEEQwdTJONBL1mQ6XU4gbjCw1XWKEs
         9Qtu1ypRBuRE8oY9yUq2GU+EDaOiJGf7xntuXdEUCu2lpgOIIMFJZx4/0kq2YO0GinQ4
         3USJgHzEo7igvlyHFXUvi1coCwPegXFbxZKvIDlr4Su77nWw3PBO9tXz7LG4lQymfRwO
         QlyCC1jk3B2wrM3bC4Ztog18Lcd22lW0PpSVDH4RgAzDpbeqbmb5dVlzlr8Zu3wpchkv
         F3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCX9MLyRB/yFMIGDLeqsBl0cG83b+Jw0NDSJrkmi69ZASxx7Lz38DjnxY6YLiN9uUT9GQYXmT7I8xt9O1L8cOley@vger.kernel.org
X-Gm-Message-State: AOJu0YxTWoWA+FM4C7AvsRbLSHNutZxiL7d7yAQruvoVQBoD4gWHEHlD
	fRWOUlxhiJpSZBxJh35zOyEH7KMDKUsluY/Mrow5caHbVVCBSZinXwDMPnNv9G+ewpA8RvvZPXI
	A2MYLSxEJETcArUfDClytn1WsfWr8gBoyWFHRJn8r
X-Gm-Gg: ASbGncs2k/NDL8Ey1t7Eni7N8bLXM/x5jf0M27MZPfRFtL7KzVhAQDWwtOpKRU+4fYj
	s+6yHvMvPkCsMCRq5kuMD36FHp+dCcuvxn2eV8EfPTxdfnKHq+ahqOvzNoivJJL38JKs2M+SoHr
	Wf8D0xY0TbYQpzCmQK1H7gfYFsxZuLwZ04hZWQ5a2WWzno/2Q0h8f42pzQ8n1sC+OpHYHJoW8LN
	ToeOdQmv9PI1TUtG4XqvNClHOzpg+HUGPUL/DAMY8ZfJj9oEvRAtJNRTby1RdpnEPzg6T1t63t0
	2P8=
X-Google-Smtp-Source: AGHT+IFZWWZeA303sSGEDumgESlh/LRzOodGJMTpQgBdRreXCi+S1ZqYksYdXXdas1zxM7YWuN+qnprX82Mkf9h3NO4=
X-Received: by 2002:a17:903:3c70:b0:249:1f6b:324c with SMTP id
 d9443c01a7336-290276bb172mr5229245ad.13.1759935243512; Wed, 08 Oct 2025
 07:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com> <8ddd5f97-79a9-4608-8a40-871fb70f2725@linaro.org>
In-Reply-To: <8ddd5f97-79a9-4608-8a40-871fb70f2725@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Oct 2025 07:53:51 -0700
X-Gm-Features: AS18NWDcOl6Dpb4Mnyl4uNTfjkNr1aNG-A0BrFI0kx3snWGrRHQVYe6VQwzWjuY
Message-ID: <CAP-5=fUr7UD1GEU67ZmB9xy6LWbYoeBgBM14_tW-tHhTdGFzDg@mail.gmail.com>
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 4:06=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
> On 05/10/2025 7:24 pm, Ian Rogers wrote:
> > Mirroring similar work for software events in commit 6e9fa4131abb
> > ("perf parse-events: Remove non-json software events"). These changes
> > migrate the legacy hardware and cache events to json.  With no hard
> > coded legacy hardware or cache events the wild card, case
> > insensitivity, etc. is consistent for events. This does, however, mean
> > events like cycles will wild card against all PMUs. A change doing the
> > same was originally posted and merged from:
> > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> > parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> > his dislike for the cycles behavior on ARM with perf record. Earlier
> > patches in this series make perf record event opening failures
> > non-fatal and hide the cycles event's failure to open on ARM in perf
> > record, so it is expected the behavior will now be transparent in perf
> > record on ARM. perf stat with a cycles event will wildcard open the
> > event on all PMUs, however, with default events the cycles event will
> > only be opened on core PMUs.
> >
>
> Hi Ian,
>
> The previous issues seem to be fixed, I don't see any Perf test
> regressions or issues when there is an uncore PMU with a cycles event.
>
> Tested-by: James Clark <james.clark@linaro.org>

Thanks James!

Ian
