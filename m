Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEC2472B0;
	Tue, 29 Apr 2025 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957129; cv=none; b=l/YtTJxpRZdKy5RWDgQ8Pzx2HLMIBi1oxEDWeJmR3WKAq9nyWWss6rOP+kjjOzu3ZgzMbAtB6Gn96OnszY/a904ngNvObzbHpSSjQg+xBtEIC4B9VEfTH6GFvTL82tbRx0/vKFk2mgKLYvJnt8Ye3WSXHvpo4gKdpAOGogAlBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957129; c=relaxed/simple;
	bh=EPaDz9srlvFWoL0LgrmxpJ5HNRLE1J4tFa1bEpEb/Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlThINGr9bq+GelIYaCHjy34/8oCvM5HDp2S78QHIUtAZt71o1t5Vq8saN0tdH797N2PxiF4RJ84dCJJtYTZYyYl7cMK20aXAQ5ATdLosC5KU7/JhUw/rUATG44nGrWq7BS0BOs6CrMaM41a5KfhB9GqT298DCwa66K+ZIW3JQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR9rDhYq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR9rDhYq"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af90510be2eso773783a12.3;
        Tue, 29 Apr 2025 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957127; x=1746561927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPaDz9srlvFWoL0LgrmxpJ5HNRLE1J4tFa1bEpEb/Wc=;
        b=nR9rDhYqYAtUl+XmMfpYxLxsaX3VhDfcM5xiE13SIeyl3L243aKBNkEP6sqBIuDz09
         MEZUNkxUZ6kxzNj8kFKLFnUS4uRxfZOFlb8/IaUFqHX1RdRW+y28ve4Wr/A1YajiiAwV
         5s/4nuz3Y5OGPsb9GzFGkO+8nWJaWLl+CSE9O46SqUydcP3jR75WnwbtK2ayYry8w838
         L9x5vK3gocZMBgssOIRM3lbECT58hUB5DV1Dbhw1IAIebcBW7e+NWJKG4VZh7vuSBDec
         j5lqkWmUnx6vuAo9mjI9uHnawnBeHOs8oO1v75DtC86BQMmwdBem0NMo7rz3LgZ7Cd1+
         4pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957127; x=1746561927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPaDz9srlvFWoL0LgrmxpJ5HNRLE1J4tFa1bEpEb/Wc=;
        b=IfKY1F0hbuPVuQEYNQ4B4mkhHC8yJDuPuicY8XU3yfYU4+hxO1LIhxKGVkGWGurWBf
         N4IAXCk770jnE5v+j99F/O4hth+NrVkMlAWjvb3E6EoCW4A04+DIoUHb7uIJ4rK/rXnW
         yAqKQYjmLZlZenT/fPNYOAvcVdfi+xp4mJOX0G2cWG33cO4uitbsGgqGZCXAvnKKT4Cq
         TDIaZRS9DEFKrry9wbSUO3m15gal/upkFjZWsyNEx1rfkW9c2F1U0/9ILbwGrugryvLw
         NHAPgtge6w9kd+M3qvI+ng1RY1pgXo6Cu1USgr1thvTerHZxo2qipQusBEn9/af3WWe5
         4YMw==
X-Forwarded-Encrypted: i=1; AJvYcCU9oyBPvSPejuvJ2Hc62X62C/hQEgZlesgg1KovmWDTNA/WT1W8/MqdcrZNZRLTy7kw0FTdfmCxTr+OBrw=@vger.kernel.org, AJvYcCVRMbfKdnz6aipoZ2vhXaAAlxxdpqBSexb+uaN/NyWpqJSU5UtHShOTPYli0OoygPbIVm2y9wQHK3Kz68m9XptHPA==@vger.kernel.org, AJvYcCWHIv4sBJUgQhEO9FZiv+Hh0nPT2IZx7xBl1qKOAr/9dE9fnfahejX4P8NOp6i23/tIkcDiLOwGTBKPf/JIPEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5vdgiJ1MGg30fF1XGJ7PVWGwPq6SPlo7Z3rX/T1XW/X38gDY
	B/1xgzgxvWejIE1mXZoxy/WU5n84EvNa3x+66w5r06qfJPP/GNTV+VBdOy27wycXzGJNxFE9IkS
	Xj1Z+qaUuoYMqdPmNKswJYMzlua4=
X-Gm-Gg: ASbGncsta+WA3x+7V3diiex6rAUfD0FuVcqLq7FEQqctFNfWvgVJxZUghHLbquMsuYJ
	5bX0P4Fv6t2FI50eHk1+usakJDDSCdvYnWYXniAuQ5VSltLEJlTWM0CebKBdcbvmy1XoZ8T6eIP
	99n5prnSlrW4YP/4heSkUg8g==
X-Google-Smtp-Source: AGHT+IGWF+l7or88VbtVsoih9aXdUV02U9Qn+pFOHncarixgIstYhZ3FKuRbLZND0+TvviOL031nXIBqToZtnStd7r0=
X-Received: by 2002:a17:90b:1d06:b0:30a:28e2:a003 with SMTP id
 98e67ed59e1d1-30a333537cbmr236830a91.3.1745957126955; Tue, 29 Apr 2025
 13:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429185839.1807005-1-irogers@google.com> <20250429185839.1807005-4-irogers@google.com>
In-Reply-To: <20250429185839.1807005-4-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Apr 2025 22:05:14 +0200
X-Gm-Features: ATxdqUHM5AHs_-EVk1tBU6W6vNSJKG_yZ1Vj6N1JMNl33Yw5FxIdRgkNWcOtSx4
Message-ID: <CANiq72kw97U_5dy1MCVRHfKUVWDfrrE50anfEa1gL1qy=yQUxg@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] perf demangle-rust: Remove previous legacy rust decoder
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:59=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Code is unused since the introduction of rustc-demangle demangler.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Looks fine -- the only two calls I see are gone in the previous patch, so:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
