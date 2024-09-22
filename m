Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA027701
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Sep 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034668; cv=none; b=grZI4gNxzv9c1sAgpqaq8CdF2052boYssvQwDRvZDkqisyYA/8hulgeuasMi62PW+wr2q5JZuParl13851OjRcehNbwFlQJKzxfNwZVnC9hhGouSaRLIZm37gBwaG3J6PMFTwS/9e4/koT4/LUsxFQiT4FUCs+FNQ6lusuITaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034668; c=relaxed/simple;
	bh=dysrqieFCLvjuMXlh4VvFMyQkvPunx3IEGVcSb6VrYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7Kp4Et0840K47R1DJQuEFJAEMf21xw7nQ1fnk+SW8UQdInyTJgFecrqaNuq1sFP6t7pmBhGVxmM9wNRB7dCe9EaMa0DpL9vLn6Z1RYEYbWdbILyeSiZjru5PmS03/Q0K34jkr3+t0HhE2kAh3xZF5S4zcPnkDhyY6K2QOOysxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=USieU2LE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="USieU2LE"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so528973266b.2
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Sep 2024 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727034664; x=1727639464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJVp1Rf9h97g7u9Ya08bmXWVz0V+212p6C9Iyxo6fCU=;
        b=USieU2LEWqpAwRhWm8pdLChDql5vaBoNtKP+pW9VCzfkHcl1HQM5HxitVv/0zV+EcL
         Y808tpRMg+o2s6o51SPnzfwlHqEa/yHVwKqMX1ZCMq9BpWwkpcDO8WdCMqikp+AYDhND
         44sbI1pebNi43d0TxQyLBBPTTbzyUgd0GP4bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727034664; x=1727639464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJVp1Rf9h97g7u9Ya08bmXWVz0V+212p6C9Iyxo6fCU=;
        b=DjnA9jz6ek9g1uUPt6gsxXYhAYhMFsJF7ZjXiGYjW1OxfbajeYOBZBlBl0u3s95XXM
         Efq8auYke6C7Z9i6kUosJGfd3V3bLR90GxdwRzGg28UxKeIOVzFOBjhZ5fOn3Gx4IH4o
         0dOdvM56f/lImJ2bSPZs4PucMNDkYYEnc9sBD384YRvbvL5Gij9gInUPtSV7CBDMiTk0
         aHl8F3XAuKvs05I0qncI7ENxSDSdyHpswMcsptqg8yheYjXMn48WeE0sW/tPGKPMRrHL
         RkfG0+Uii6zlqn9bMWIuGyeZhPyagLLhbOzni9NC4Skf8w32706utuOlj8D4UeuhSUoU
         ml4w==
X-Forwarded-Encrypted: i=1; AJvYcCWJEWLcMI1ySNUz8yE9ochCwZRV+A2K+YNC4oww84ig66VcTFB4WpGfFLKMrRu/ROzeKEsnKltC1rQ/AE2eRUnv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LvRtIE8qlbNKjQjV9biZKdPRcGgyHw1hgRzfWGV3QnJYVDTW
	t7s+W/aGIFuAaKvDYnbWMM+j6/PIKxDI2adE9wDgtQ+gvF5EPNTQqvc59G+czdtGwGLXnjrNafL
	uuPo=
X-Google-Smtp-Source: AGHT+IHhqvjVUiX4r81mN59KqqEHzZrG2IJen3eUgimoexJ3KmUVNhhiP7+AaOu9l+IJY6oEkgg1DQ==
X-Received: by 2002:a17:907:7e9a:b0:a8b:6ee7:ba1e with SMTP id a640c23a62f3a-a90d51967bemr957727066b.60.1727034664513;
        Sun, 22 Sep 2024 12:51:04 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3acbsm1112869766b.64.2024.09.22.12.51.03
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 12:51:03 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c46680a71bso2705966a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Sep 2024 12:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYFC2V/BpjlOeIIBFRP7BGIIS6yvdq8CfXcOTRpJRWvVzzwVCy8+1PVq8K1roglg57fVeDTBSVl4hSsWQxviT/@vger.kernel.org
X-Received: by 2002:a17:907:2cc7:b0:a8d:29b7:ecfd with SMTP id
 a640c23a62f3a-a90d5157361mr1240658466b.54.1727034663286; Sun, 22 Sep 2024
 12:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com> <20240919082624.05ca5fd6@canb.auug.org.au>
 <Zuv0kA-um9ZT-Tjd@gmail.com> <CAHk-=wiz_57SsfaX1JkmDJ2sMo9Pfiq27XciQeh7GE3tDBVDFg@mail.gmail.com>
In-Reply-To: <CAHk-=wiz_57SsfaX1JkmDJ2sMo9Pfiq27XciQeh7GE3tDBVDFg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Sep 2024 12:50:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjrLPDVMu2Bj+01XmZF=puP0nKXbLzC40fe_enGDdcBg@mail.gmail.com>
Message-ID: <CAHk-=wjjrLPDVMu2Bj+01XmZF=puP0nKXbLzC40fe_enGDdcBg@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Sept 2024 at 15:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 19 Sept 2024 at 02:53, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Thanks: I've queued up the fix for this ARM warning in perf/urgent and will
> > get it to Linus later today.
>
> So this apparently never happened.
>
> I'm back home now, and so I now do my arm64 builds too, and it is
> indeed failing.

In case people didn't notice - in order to now do my now usual full
builds I just took the fix directly (commit 673a5009cf2f: "perf: Fix
topology_sibling_cpumask check warning on ARM").

                Linus
