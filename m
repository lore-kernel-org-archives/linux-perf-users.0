Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C9D1F4635
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215415; cv=none; b=Q1lFcsu2LhvMdpxyOP0f6W90E07a1G+JL6IfZyNSiX2qF9HL87hrxfktsHNu0SEmgO8V32o8wLOt/CXzy/4Cnywn8M0EoVSYJynFPbG0MfC5WinGXpGllmPlZ4N94fxtZ4f7y0iHqgJrgkP4lpoCbStCc+R+hnalPxuetn8J6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215415; c=relaxed/simple;
	bh=BS8wCFJbHRJqkYtqoIWTi+QgcaGE16H2XbnIZNA9VPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZV5+4U4/CH3iFZ1/TaQ0IWIH1213SBVnjcFtleQ/zp9io1ohlWS5AThvzQLZha7P5vUxM+J0fQMRXkaUD8kZQQoBZekmGxBJpbCkOcB5NrRBDMSKAHcDoK8OQ9Jmh/SWyGm4yBFr0V7x4ta2iw94VAn2Jm6us8gULHJyEqwoVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrXJ+dHG; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrXJ+dHG"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d147331fb5so16455ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739215413; x=1739820213; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS8wCFJbHRJqkYtqoIWTi+QgcaGE16H2XbnIZNA9VPY=;
        b=UrXJ+dHGsAc8iSShEW811toaiGt13hKz/q0okxskzv5gtbARvjK+fBrG1CQ8oJUUf4
         pnyQuAedWpHVhdGFFc4J7k7tvgUbHW9rTSD28Im6ZSpj5zlF3q9dXF5oO+Aav/bmPJrC
         hY+P7OcM8lBFQ8aX19pyg9Vpw9aRe3fQ3m1QXChSXiscBbFv0j401j6UoE7eSMK6cBdH
         2oALClPF1qjFzZPLp6QKXpuz9tJoWoL59Ufo1QWla+2W5+KVTZ9d/Tj50mIohtjWj6Rj
         kXljbcpn9o4FeCk3fGGvY5oLvG9NhXNEPGDREWbD8YNgWRbrZhqv8tCKftmyXocanUa2
         mziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215413; x=1739820213;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS8wCFJbHRJqkYtqoIWTi+QgcaGE16H2XbnIZNA9VPY=;
        b=SGAAC8uDJx4eH7NiLK4s369zQ5U97RF/CbTW+95KMgpcWQVeiUqldpZDFajcN9GKtD
         Po1msedqBlx6inFh5CM6A7DDFHUVTYJNcAyB5Po6gBMNjAWYeiKkM786jmeQ58BAtnrA
         7hDcd+2NZQ3iLoJtJeCR+RCHHHVr47WhquImkQ/05bEPEUyTBZfaQDW2nPB/PDfu1klX
         syFvp+O3CKbFd3vCZfqolBqbzvMDHjRm9KSPFWKzpti9UgifPRR1X4SsFbXis9hTkHIR
         smmVrI1tkobfGKjyY1edW8i6D/FnW9ShBFfzM7dQ8dgTnPJNl4t1hH1LUfvyuNCD7qmU
         Fflw==
X-Forwarded-Encrypted: i=1; AJvYcCXLJ3VyOdhvySYR6v/KbwZAJaXSV3mjSySuJed9I2fKOaaKlPITcbvA4v6whj4l8vZyXjOEjNZ9wIuR+lz6w7VZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0LLl9jCVqNk5kxmVzO5CP1/AoaC4B1iE1JbftIRSFqlYcNCB
	IelsTA1p14HKoxNZJkjD6F/LBkgXnEuvHurcd5zXQozhhiGA8XDsURbszRyRpLaatEX45l48fyB
	RXmPwkh8jsL3AC58wh/8E97SHpk5+n++Qn2Z5
X-Gm-Gg: ASbGncv8Q9NZFepLC4smfjhDIZDTMcX1FG53PMtYCf1jh6Zvk2gwmav7vuTpFeIM+uA
	tWo6dfGMe1a4nwgTCzXYSeerd/zCDsw2a8T8JW0v13GQS0g4MTAN9M2oONgoTdjAhvKLJjJ9+1s
	eO3sQObRr25pEa8ncetNCr3A6b
X-Google-Smtp-Source: AGHT+IH4QBrvzOcxvPMkar/gP/Um8LH1FrS4euE+Vwj+OJmo1p88lMRgvpVy8FYhzyn31tVt4am1TiL3z0tt7Ey2iS0=
X-Received: by 2002:a05:6e02:388e:b0:3cf:cb47:9963 with SMTP id
 e9e14a558f8ab-3d17036d434mr169655ab.25.1739215413262; Mon, 10 Feb 2025
 11:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109175401.161340-1-irogers@google.com>
In-Reply-To: <20250109175401.161340-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 11:23:22 -0800
X-Gm-Features: AWEUYZlqVCZLMtiy5hrxvQ-Q5BOE5craO8pQO_xiEl86uzRcCMz1ou50_0XDo14
Message-ID: <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Tidy name token matching
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 9:54=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PMUs
> before parsing") names (generally event names) excluded hyphen (minus)
> symbols as the formation of legacy names with hyphens was handled in
> the yacc code. That commit allowed hyphens supposedly making
> name_minus unnecessary. However, changing name_minus to name has
> issues in the term config tokens as then name ends up having priority
> over numbers and name allows matching numbers since commit
> 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with digits
> "). It is also permissable for a name to match with a colon (':') in
> it when its in a config term list. To address this rename name_minus
> to term_name, make the pattern match name's except for the colon, add
> number matching into the config term region with a higher priority
> than name matching. This addresses an inconsistency and allows greater
> matching for names inside of term lists, for example, they may start
> with a number.
>
> Rename name_tag to quoted_name and update comments and helper
> functions to avoid str detecting quoted strings which was already done
> by the lexer.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. This patch addresses name parsing inconsistencies, in particular
events may start with a number without a PMU, but not with. It also
aims to give better names to patterns than name_minus and name_tag
(with term_name and quoted_name respectively) that have drifted from
their original meaning and become to me less than intention revealing.

Thanks,
Ian
