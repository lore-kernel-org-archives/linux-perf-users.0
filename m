Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68B29CEB
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895802; cv=none; b=NwnUvfVZr2sKnDt/gvypSbvgxWm4XjF3fku68NbWuDflLh2FhmPUd/eGkkiraaOqFFDixlOFSLI+OQTdQHeXv+nYc/40Si/j4DH9PZkv/rNcNzgz3tTpIoI+H7gT+CnQWOOoPLyV4O+CW7EFyt/1ar71kKBl/mZjqGD9s5U6Y60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895802; c=relaxed/simple;
	bh=uFpvkiN+G0wcQVjOlr6G4EunY533wLdSbYoyi98Hhu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCcoiT8hPqzBePa9VRd5TmfYlGGqwjKcqc0GElGFTBOAjd7mItSHH6XWY3TCNt83rWa33DTEZKgTzYn6Zd0qyzHthZVOiQ15FRoRbhhC84bXCOcOxVikeJSCMEBar/ue2bTbGjn484Vhm1mCgEqwqwT3v6Fd+RKTBE1SoeJudRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5l3AdXQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5l3AdXQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297dfb8a52dso126715ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762895801; x=1763500601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPCqA1l0SfRDCEzSSk3NUmkIaPJfMJM7jIDnXpJC2Ug=;
        b=P5l3AdXQhzcj1QEYIOx6UTntFI0p7C3cTyW5em4LR/asPqcynk9y/E/WifHth6xtTZ
         fgiOOXjUXEylq5SI7h6vHQ1vzFepKON0hgvEio+0xbZCmEh17y54O1TjZuvyKB9bFyQl
         UFlBNfCP159nYbXCtrwjDY+0XzwX4FcFl8JC7RFhR9TkvqZ4UyTxrGmuoHdRYHP0o8rR
         I7pHd8ufdDImQ7PWMCpHSha2JPVoXF1EdH/xVb+S/fTdLdTb1dPppM07/WvtRNayvtPv
         oJRDqNdnS1oN6yOoESYY0frb74ubPZuTl+nA3gkIzfxO4riZ6IO8ZfhI3b2+Cml7wJPC
         LZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762895801; x=1763500601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mPCqA1l0SfRDCEzSSk3NUmkIaPJfMJM7jIDnXpJC2Ug=;
        b=fz0yKq+RwFqhhtpB8KgMa/fvQ3sFOV4iOmFFAFfiWolPbKorSUtGCm9Ln2L8FrWwbS
         DP6H0JYZAeYgxkaruchMFYY4U7Vn0d78zvcdURTFnpb8yuhHy08ls7EJIQRFamssav77
         kyuz8ICwLimuABhT9ZY/6EHebmzTOo0ymcR+kvE517w4GhUnBO166Mvei1lyVpOzoDdx
         YqpmxVo8JIF0ZWB6mC/wyUMqmoEtf/FGfWswvi4fEJ+zyTSNWLAvzZDUqyl760iqyFbd
         1cY27pRFnefLATpKdGoizX1rqUnytUp2rHMqGvJhzq4YKZygmumVF7RbIImg6HHrs9ER
         ivGA==
X-Forwarded-Encrypted: i=1; AJvYcCVniicU6WTYAudyEZfHwe2lHUUFjaMOMSRqa3rnHU5VkW5TCORH4Slb7zdMqEfDyVaJhzb90+8qyWpq6F3/X07H@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpd4eh1lnPlJQSw0Ivz7PLIbaoRbwccqvjlysvMd4tK8Qm4Qt+
	wQXfdQpXnWSE5SuqUL2Y/CKPCMEjwzXrJxvIPXDcDE86M2PVb826y8Nq+Y7b7T11OFMVyJ5MjT8
	MKRTmg1+0el0Zz7LaUqitM5a5r2GikxU=
X-Gm-Gg: ASbGncuCT7gSTl7DUoFLnoCYA2lA0FL3IdeoNiE1dERB5pVyQQtMXIXnkYD8ezSENwR
	OAjgx9j0pTZ1KbTd2EAVpnIY8RpPji20kKia+IX3lhzENh0vyhx7i57IEZTq0xhhteXiE2qYrK+
	fLhgrHFEtPFuo1DEOK5Ri6Geg1MDk2H9pzrddenlfQi1k8Jizk+fnYlSaTqJNq0PfeXplQWYTcc
	QKtDzbNQplovd666ZWCOPcWr6+l+R7mDIWiLooe0B/zOMwMnE9vTPkNj2vSU7pVEcP2KTNqRmkm
	5GnGt5Hmio3bcktchr7uBcbZsaq3YuwrzO1GPftNA/E9plpJDtMkmoUXRC7Nny10nKxCnE8Sc43
	gem4=
X-Google-Smtp-Source: AGHT+IELxTIhnri+tM+aFMyGi4F2LNmIkSlKfOVg2wV28KftvFNGNsUXaSgAchbqExqA/Xn5/l63ZOKOPdX8SzP3nEo=
X-Received: by 2002:a17:902:f68e:b0:297:d77c:ef37 with SMTP id
 d9443c01a7336-2984ede4fc8mr4770075ad.9.1762895800585; Tue, 11 Nov 2025
 13:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQjua6zkEHYNVN3X@x1> <aQltxZIVd6w5VNtI@google.com>
 <aQ0ERJiTpiA_rL5D@x1> <CANiq72ns1sRukpX-4L3FgqfJw4nXZ5AyqQKCEeQ=nhyERG7QGA@mail.gmail.com>
In-Reply-To: <CANiq72ns1sRukpX-4L3FgqfJw4nXZ5AyqQKCEeQ=nhyERG7QGA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 22:16:27 +0100
X-Gm-Features: AWmQ_bled1nlXpHtecW_FFs9JAWbht0TitHTuf5j8Tw1cdC9Fo7wx2-8srRyEN8
Message-ID: <CANiq72n88P_EYzS=c1Jfgv2zA-APJT4NrFE4GwEoQtbVS6bpPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf symbols: Handle '1' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Zheng Yejian <zhengyejian@huaweicloud.com>
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

On Fri, Nov 7, 2025 at 2:35=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> We don't handle the big symbol double-byte... I will send a patch.

For (cross-)reference, I sent this patch a few days ago:

    https://lore.kernel.org/rust-for-linux/20251107050414.511648-1-ojeda@ke=
rnel.org/

And then Gary told me today (thanks!) there was a similar path a year ago:

    https://lore.kernel.org/lkml/20241011143853.3022643-1-zhengyejian@huawe=
icloud.com/

So I think we should take Zheng's (Cc'd).

Thanks!

Cheers,
Miguel
