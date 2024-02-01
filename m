Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5583CF5B
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Feb 2024 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822497; cv=none; b=Y1KhIi9n6FQwA6lkGdzMODM/6zvyXKkj0B9j0XrC9ZUj77CFKIdOBTh+TXWqtdDouE5x5KqM9K0Bxsdntl2xow4/ZbhQ6A68uoYH/zlJAStxNIan5n5TorQpjn81/zYFulBIE3Mwd5w5utDzPdr5CzWkyrtScBvKbvI3K8c3fV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822497; c=relaxed/simple;
	bh=jrI8ExyERWG4CLM/V0Lnvn/sGlAkaSXcTtBVtgvdqzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2JDo+jIwpTmIFbxQ1s4bjVrg/WWmQpjuTO8XzlaSMcjFYfJN8vdXWci+lzuHoKHcRlIv6gNF+t+M4PugAYKv5wvZ7c+5AqiB2Ir1+RAHfsGkg2k8QHnNF1JXW0b8BWIv1P22V/hcXk1k9gF9ntAsxcN8GhBLHLkd9oiTDNWW+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=drVitDBH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="drVitDBH"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a358ec50b7cso28552066b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 13:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706822494; x=1707427294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WB3kXG8ybGFOWiQ7cR9rzELbZ2l6A+yjZADDKXb+4k0=;
        b=drVitDBHLUwBQJnpATMJ8wZUcp6/I7MsjXrgA7t0f5FYosRRyl7luW8OhhRFpePUCf
         zf1hzSizrGKSo3PVjuJeFe2IqOD59yjC69OIXVLZrd6d9dXfTHRs91hB2NEgGH+6J7Qm
         mQCkva2+fus9RyG3hnCzn+01WBT7BCDT4dvrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706822494; x=1707427294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WB3kXG8ybGFOWiQ7cR9rzELbZ2l6A+yjZADDKXb+4k0=;
        b=wBc1EEcl+lfQQ234CFkAv8WdOYJ/BDUXUlj3Z++fvERUva7c0iaOpX8cvc6IIgzVSL
         G9gXhqfoQGRTe51e2cqO79v+mNfGRoprvsRiMGMtGg8tUSMZolVN6qXQtdG7D+gahwcQ
         AUlQBRvTaof0x65TaPNT3FGJpaczWhxPGesgivnuwmBFfIIFmbmRlEdIDv1WRueu4XvG
         r9CBp6sV/rIDR5bmKoei31voLlpzVwsnuj3C8wlk6nXuIPVECARnx6acsTI/L+KKmc8t
         ihNfBysqF9J1on89aEDpnTdDW5G+yT6B7Xi2ugD+6sQit1kihEOBxdVdkmvfOm+9dBnh
         Fwag==
X-Gm-Message-State: AOJu0YwdaDrwUEggFlvcLk4L3K91BseSzR+xrr79biN1h6SMfbfCoAFj
	Qso32hn6AuA0UiOrVc/DnBxn6L7CNw5YLoxqwEHTcC8KIO5zF3Us6VrvN66WsMlqED+2lLOcZJf
	tuNX0vQ==
X-Google-Smtp-Source: AGHT+IHYo5YEJoprAhJ8UzG3d7Bntba1nNTQqaia5JVX0qakya13qEpT/SjC9adNA+ADyfyBqPMtxQ==
X-Received: by 2002:a17:906:3657:b0:a36:cec3:bd88 with SMTP id r23-20020a170906365700b00a36cec3bd88mr164904ejb.37.1706822494106;
        Thu, 01 Feb 2024 13:21:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWw10V7HAkFqQK7c0BAoqpH9hwsbfakv5yqqcgK0eeowCzfr9/TXs9LuDY5xiJOQv90qlOBSDBc1vG2isaWJuQ7ZPJ60uTVae2efEhPilNyxQ==
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id kk28-20020a170907767c00b00a354f8fc19fsm168616ejc.214.2024.02.01.13.21.32
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 13:21:33 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55fbbfbc0f5so1806993a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 13:21:32 -0800 (PST)
X-Received: by 2002:a50:a691:0:b0:55f:e2ee:6bba with SMTP id
 e17-20020a50a691000000b0055fe2ee6bbamr204398edc.5.1706822492138; Thu, 01 Feb
 2024 13:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201202254.15588-1-acme@kernel.org> <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
 <ZbwJrkkQbUxw-hyb@kernel.org>
In-Reply-To: <ZbwJrkkQbUxw-hyb@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 13:21:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVxsBrf9hme-VQ+h+h6j3V9n_ph0ALT1EANDiEKy3uHg@mail.gmail.com>
Message-ID: <CAHk-=wgVxsBrf9hme-VQ+h+h6j3V9n_ph0ALT1EANDiEKy3uHg@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools fixes for v6.8
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 13:14, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> I should've known better and not send the noisy JSON changes at this
> point in time.

Arnaldo, it's not the JSON changes in the history.

It's the absolute garbage in the *tag* itself. It's crazy. Do this"

   git fetch   git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
perf-tools-fixes-for-v6.8-1-2024-02-01

   git cat-file tag FETCH_HEAD

and see complete and utter garbage in the tag contents.

Note: that is not a change *made* by the tag. It's literally just
garbage content in the tag *message* itself.

You have something *seriously* wrong with your scripting or tag
creation workflow.

               Linus
