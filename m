Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC917C9FB
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667534; cv=none; b=RFrpvH+3IKBostsIfbVmS1GXbpGWezdHQH5hs2xmNN4qBLrAzA5ewyScXWXMkTbHdr2FZmuLRsMtN8T/IErvOaWuQDl1kHAe/jDqO1Pnm+HPyyWJSvmAyGOS8C3XmeWnI99cxN3HxbSgj4H8CRe1Nzc09X5ABkCc6UJq9/EAfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667534; c=relaxed/simple;
	bh=hzMInXZBrq08VfXm9EodIoLXJ2qNXwWHpR/vSZpB+as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqIesnTY73eydebrUpyIPlb+pwABv/iWm/fZSW+ddE+rvB/wwUgEqQ77JqG1aCoTSj3iffyO2e92ip9RMHJUgZaKrol3tUunhpvloQ9xU1R/wW5FQSr3ggVjSQEihfJQYPvOXQwpKso666Yt/40ufGCa38qEPzM8ajpT5p7Hl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gtk1a9bp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gtk1a9bp"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaccc0979eso9178461fa.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jun 2024 02:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717667531; x=1718272331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzMInXZBrq08VfXm9EodIoLXJ2qNXwWHpR/vSZpB+as=;
        b=gtk1a9bpnVtDocVdEOLvEOtSatyS73dq6dJfgs1U+WASwtsiqzSuVhHfb0c2T6rklL
         HEBfmgXDL587gyb6sDVbecdU7maBaPvdxalvbmUw4sBKfUY8EXlOtU+hzixVOJiw1Z1t
         iVw58P5FR2jo1hocr6P6kJCmL9NRP5QSG28dofAGZiMyFrUjBqtV6fQbxEP+PprfUYmn
         b00b1+BLLIOROzaImz6CTvHi4mN3qzotw+BiFqecf0LMDG3TQ0t7plzlq9usP4L5CWsg
         FEhh6cFj8JH7pmSvVSFy5LjBuer4lKhswukaCZDnFfBR5XwmuSjeXKTQO36uWCzQ10b0
         JiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667531; x=1718272331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzMInXZBrq08VfXm9EodIoLXJ2qNXwWHpR/vSZpB+as=;
        b=RjWoyLDkVeSN3cyYLClauK0hpes9+cgmp4dpgc9U6wzFxstfgFbY3NRwI4h94Lyaqx
         gJQwsX1BZ3ngwhMCxo2m/jaKhq+fn4w/Osx553IHvoocfu0qb8lFrQv33yLOs3fD/ko4
         ZCEYchiDV99UTfp2pH3BlRI55irJUytW3BML4bPZa6wiTZH9HAn2QlJt13Uj6EV/LnmX
         2QNstaSHa4kPAa33KqsaU09ZKScRS1s9R36JKY2juiCHA9T4RayE+aHam+DBDAhrRYfb
         jtKlXFYAPvxYNJoL6Ti3psIvtDjRK3DcUeiCj5cGAAG1RrF00HqjeKXUsLMlxvgDvDg6
         9qCA==
X-Forwarded-Encrypted: i=1; AJvYcCU56FBNYIIKQbX4VhcY9IK2MOyUEvN8d5kB2E8HKdNKqKTrsLpVuUXjwL6J8hqSs6hdolfW0bas4a81H0QrUhV3JVcPBW50QCDG5LmRQDPvUQ==
X-Gm-Message-State: AOJu0Yzd92KFeZRluXicP+F7jt2Tj5a4B8i/e0a0noy5YAF4lyUjTG2j
	bgObY/BOzq8xwNbLva7N8zNEDZEpi631bUQVzF8e6w8vlRbTBSPK2K/UC/eBNfs2KWBJEEvxQwU
	auVxrinOrsZqMfrJXaPZ2NgtRReZmzDL6YhcoKg==
X-Google-Smtp-Source: AGHT+IGRjxg5JxSkcZ0TIa9nvKzj+6js95PShzriLgFiyIk8WZvSEOxoci54ygHxxx3XlK6Ngc3iCOMpgDTyPLdieC0=
X-Received: by 2002:a2e:9617:0:b0:2d8:3e60:b9c9 with SMTP id
 38308e7fff4ca-2eac7a82898mr28203101fa.33.1717667530690; Thu, 06 Jun 2024
 02:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422080833.8745-1-liangshenlin@eswincomputing.com>
 <20240422080833.8745-3-liangshenlin@eswincomputing.com> <mvmr0das93i.fsf@suse.de>
In-Reply-To: <mvmr0das93i.fsf@suse.de>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 6 Jun 2024 15:21:59 +0530
Message-ID: <CAK9=C2Ug2gcS5Rbqc9EQ6mVwrJkoeLscOm6wtgqGKHdqEdSpSA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf kvm/riscv: Port perf kvm stat to RISC-V
To: Andreas Schwab <schwab@suse.de>
Cc: Shenlin Liang <liangshenlin@eswincomputing.com>, anup@brainfault.org, 
	atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:10=E2=80=AFPM Andreas Schwab <schwab@suse.de> wrot=
e:
>
> On Apr 22 2024, Shenlin Liang wrote:
>
> > \ No newline at end of file
>
> Please fix that.

Fixed in KVM RISC-V queue.

Thanks,
Anup
