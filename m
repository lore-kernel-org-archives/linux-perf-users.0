Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813635CBB2
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896039; cv=none; b=SHYVoXeq/94XC9qRr6S7mfwapEez8Af3Tf1+OQ4rUCW90dS0kKMfaAzho5DYp7jHof0eNlNIByEAbu9o4hykOqzW3sCdqPoHinY99/fsbBX11jQlJnHBux5cilHABxDVtFBVb3LkGScQ4G3pMLdvbjPKbJEQJR4O25kAxt/8pZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896039; c=relaxed/simple;
	bh=v8zrmStrOB2YefB8pMgq5xqMp6puTEeON0d9fs9RE4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aj7hbrX8BzAN7CUP/S2rvNzbbjPZafkc9IDv2G9Tm8nmJBJSTL7W7w1N745Fi3IwZVfQHehCp7y+69JOYjYnpkp1o88rWDeUlT3AjuOE5gBsSFkJKEyxw9iIIxqb/sVprxttR68Q2hNXLm4eMai+bNtuLF4JReEL9gIiQTUKXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgZGGgdw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgZGGgdw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29800ac4ef3so281335ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762896037; x=1763500837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8zrmStrOB2YefB8pMgq5xqMp6puTEeON0d9fs9RE4k=;
        b=KgZGGgdw+GaprWarNjRPtVgAVp+bUyzIxcjjuQKwkfADT8DeJt56C/1GR/juEk2k2Z
         AKI1TCxeybliATWRFqzD1atRxofNTBFDaNjPyinob4udUTpPvn52ItWbMgDRNha2S4Cb
         Uslkeg1EzC3rtdTT2oALu9AGN3sBafCAOOzHrA/n7LVLKeqBi3ZZcKHYOOu9VcHhl7IX
         GHLawwxvpvQjUwW9CpQ1IlXLj/xsV3xmGOJyOoIQXqtowog0cZeDQAM10/L+56oYk56k
         CL7SrWTj1WUOWCRogmtyE/NdOVhICf4CVGNIcEAc5a73RoFKH+H0CM9SHx21a2XhMYcy
         ceXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896037; x=1763500837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8zrmStrOB2YefB8pMgq5xqMp6puTEeON0d9fs9RE4k=;
        b=LkBFI8ICsUbRtkoPrglwt2ZrHgEmfYtiXLCtSC+SPkeRJipEPcNKDAo9wjpOngPU1U
         ZbqubtKBEM844BFu1YZzLnkL6cmqMUqb+KJzvMskzHe0XANDyaX8R9sIhwyqlS6Hi0Ec
         90ZAYTPcr0nHSo1zGSihDwrioHqaluduycsKBLqsxe7gi87ZC1khoLuD3WtZf36grS7G
         x17KIGUy5nIGNr5C7I33mn5pj7ZC7wrgfJYnjkk97aVUInak6IHlWIUyW/yWBL3tJco8
         gWd3TRVMArM9FKLPMrR2b5S9NXIS3jvz+8oRcj8h8F0LjMIB8jYvU9802YqZyKoIZMyJ
         5BlA==
X-Forwarded-Encrypted: i=1; AJvYcCUDp3+CYrmtY+Eztyt4k+TDwow1tF1JMIr6iYeRT+6/1WkjpFV7Dt08nj3qU9Rg7orzzVJ9mygOv4PThiGcvxnw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6V8Z1fZzE/ATR7xQ4SAB01pDdS9AwiIcjbZ1g4fG5OIPGaxnP
	kS+7orV6gU0uET8LycPC4JNOil+jn+8LDrTWzTv/cQU1QrcaCqNAhP/WlHOEyO/YbUTKS+4VMyA
	8z1mr2Ufe86ylkZVb5VMOEAqUD7rZvf8=
X-Gm-Gg: ASbGncu97OU+24GoGMehbK1g6GJ89PQb7NY5IbuHUE+llogzPlb6rO5Of9XyPhVmjoZ
	xh90yKbgwIpA3TU5kms9X+C71pmaT1+ZnCme3YrGm5lXw+D0uLnRWdpBSeYm0CnEE49K+ruiauu
	5a9DBAhrIVBrydJP6dctWkUaxLrZ4fClyzaxSIzV9T8XN77bfM+vhuMqE5GDoHzdO4TBYCGNcjf
	JmelB6sjOpukNCWLUahWtGsotcKpiloH31XB3phw6Dqm9k6B6rrkShLasLZChPOwcaoJdNJjU8e
	O5EQb695iCzaTMknpHqxKoedAt/UI0XW/yqFqTirkCU3f7QrlWzqMk7cS60+iZpE+ZBx5YgB8B+
	EyCPGvcPJpxrgAA==
X-Google-Smtp-Source: AGHT+IHl8mEgMQn7UDgpGJGI6JrIYwGTu2nAkX9KR3mFqPDmuAlwBOrcaq9jkHJGusLGYRhD9JtH0UuRwvwmJmtxgMU=
X-Received: by 2002:a17:902:d2cb:b0:298:f0c:6d36 with SMTP id
 d9443c01a7336-2984ed87089mr5137825ad.5.1762896037036; Tue, 11 Nov 2025
 13:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQjua6zkEHYNVN3X@x1> <aQltxZIVd6w5VNtI@google.com>
 <aQ0ERJiTpiA_rL5D@x1> <CANiq72ns1sRukpX-4L3FgqfJw4nXZ5AyqQKCEeQ=nhyERG7QGA@mail.gmail.com>
 <CANiq72n88P_EYzS=c1Jfgv2zA-APJT4NrFE4GwEoQtbVS6bpPw@mail.gmail.com>
In-Reply-To: <CANiq72n88P_EYzS=c1Jfgv2zA-APJT4NrFE4GwEoQtbVS6bpPw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 22:20:23 +0100
X-Gm-Features: AWmQ_bkSWVNPsGVVdALPpw7bhPMpWSsB75qQDKFvI8M-tKGlVQ29n-geA8_Plxg
Message-ID: <CANiq72nx7arn4+Uh_XiikagnR1ULx02jSZLca_aTr56w5A0bzQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf symbols: Handle '1' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Zheng Yejian <zhengyejian1@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Trevor Gross <tmgross@umich.edu>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:16=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> So I think we should take Zheng's (Cc'd).

Trying another address, since that one failed...

Cheers,
Miguel
