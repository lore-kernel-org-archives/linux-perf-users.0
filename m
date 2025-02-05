Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9AD8C11;
	Wed,  5 Feb 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760387; cv=none; b=SfGGcroI5EtizQyhnPWM5tqP84AanI75TmoYgifIw9tD2dGdx9yAWO3XOfkfckSl3wIi/8oe6ZU/s5SkxXpqQKkbaZusp372/bLJQNF+OWZINbffhQXUEu35LzlXarq6LREDwwfta1bOmvuhUJ5DkMdcL4XYGqLH/s3P3o7DHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760387; c=relaxed/simple;
	bh=26CJ6eCx9sOjWqCu2BT3cZKrGbPD0dZZbBOZtjTojz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKv1JxeD8TCnCnhPWv8mwBwyY6AxXH7Km5KbnImV38EN6D3a4HPeajaQBaca9Kupq7/SkLjd+c6Vqugg36NLz/PW1+FnEMRs0t9R2h4SbH3GoiUhmwPcz+a/LxAcHGbk7jTtLKbW10ICdnxevmXcP6qx8j9aXSSDvmLbnzxWEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzadPKl/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzadPKl/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f075df4faso3025855ad.1;
        Wed, 05 Feb 2025 04:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738760385; x=1739365185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26CJ6eCx9sOjWqCu2BT3cZKrGbPD0dZZbBOZtjTojz4=;
        b=KzadPKl/OY8u2i8dSIy+abZ8nKMlVt+AqY0Z1V4s5UuBTOep5uiTMKYlqhyxBVqkes
         i1nFeAcksNXh5P8133kZTr1SvmvKJXMrAEDFhLMSZ0parw+TLyDnpDDjM2/zz8i0Kwcb
         opfOvQflc9jVw8kty1Cd+qY/5oOPp0I2RAAkFIgNryfeUwVKxBteqqETNBdLkAwVfmNx
         Vwx+rMZlU45ziLsO0Vd1O+a4fpuQqsEsgxpnLbfPvL2sEI5wXIUML+hYbtAMuisZMLjV
         nE6d3rHp1ltAC5Oy7gWsrKKxyyyUrC+aUjp3ykwnBcTWIMRUKoyx60NWnmrlh1xQEjuk
         zTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738760385; x=1739365185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26CJ6eCx9sOjWqCu2BT3cZKrGbPD0dZZbBOZtjTojz4=;
        b=Jsnbr66MhGH/iitMQUL4SpmmtvCWPq2iblfCzWn7wxMroniJJbQpw5A/mc3sN1ywyX
         nyJ1GijqNDVN/GCymX8vYtqaL4DWtBEmZupcul43W2b7R/30ZLqaDneIVvsb5/DKwkYe
         nL7orkBi/zZmPMU8iUueiD6+n5STRnYhXKnMIsMPaeyZeO9Ix5AQLxJhfZHqzhgEZM3j
         Slhz95/QY3zNawPN07RFYQBJRjG4D7GCPoH38tByf/KVBiorP0JSQ0sK2UXK6hmG4QDs
         dkKslNYPdK2COfMx4nNtX/fv0XWvkPfW46eDA81jArPVVH9MNsN1vyEuRFkN9AzKVHXm
         C9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU6xMt14VN7Sm7ZopCZniDL5vzgh7yUGxCYS6ys/02Az8HrAW1jt/HMT2JmQJR5RPe4+0dZGMXRkhEfWOj1xE8=@vger.kernel.org, AJvYcCUfs4I+lbXZ3vDw2AmmV0LMQRY6VKAA3mLpjcaiHHM6KpYUt+M5Tj1uyeUoCOpsdzB8qTORzJZRe879bdChe0CacQ==@vger.kernel.org, AJvYcCXP2yTDW6oZq0PQT2r5e3FO60GhkVHjdNFKTEUzY4wSyga1FCRZBwkco5/XHrgiH8d4QOCaYOVNppe+III=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTvzvbUseCtHfue0A+QxAlpVaSvx/fLJsS/jseUBID80qXtQj
	O9hJk0HoW7f5oQerfWgIgE8o6HbizWvKHgTPR9sv/7km/l25J2qOye9rQ3wMRRQEwTC5pT3XP9k
	MfdVZObyJooXkbaqZddHLzfQguCk=
X-Gm-Gg: ASbGncuHnzjhB6dIEFHPy+P4/690Ycb9p7dTBiwdLomrV10Dtm0uUolQTwsTt7wIdiv
	uI4LMk845S6e1k0JYPzwqKNAgcY6h1tDwUasxXFBCCB+gZfIn6bL2PdKMdYjj6pkNhsTwZK+W
X-Google-Smtp-Source: AGHT+IHkri6TNGTSz3U98mXqrXR+r+m35ZqBww+i9hywgTl9AhUoiMtLMP5LF8FnMwbhi4COMqrpcJa3lx42SSdu2wM=
X-Received: by 2002:a17:902:f54b:b0:215:3862:603a with SMTP id
 d9443c01a7336-21f17ec5e6fmr17560075ad.10.1738760384836; Wed, 05 Feb 2025
 04:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129193037.573431-1-irogers@google.com> <f500ef21-5c87-4c60-8453-d98ee637a60c@app.fastmail.com>
 <CAP-5=fVJHV=JgR_FR91V6zcVnLXnakdoiNP4Y5j-+X72r2STmQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVJHV=JgR_FR91V6zcVnLXnakdoiNP4Y5j-+X72r2STmQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Feb 2025 13:59:32 +0100
X-Gm-Features: AWEUYZlorAPRmvHCC4L-KWXHG1tDMTWJUpQRUhJNRpESCja4Y70e9BTk5q_UtPE
Message-ID: <CANiq72=ynvE9k2=78wsVoM5-YVFBhTfNCKBeW7SOrNasPdihzg@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Add rust v0 demangling support
To: Ian Rogers <irogers@google.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 6:20=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> I think the best solution is to use the official demangler but in
> general we'd like fewer rather than more library dependencies. For

I agree, solution 4) seems the best, at least for the time being.

Cheers,
Miguel
