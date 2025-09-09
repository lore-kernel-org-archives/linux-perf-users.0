Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64E25A32E
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Sep 2025 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387630; cv=none; b=Nqo4AM6FkgUPgx8puTA8L9XZwklsYOEqQSC8BQNiOfcxoHpAh9/soJw9Bp1kJBE670uVByBhrjMIJWB/S5ZEsZgz+B+rwl7SZxJecFhKilaAI1Pz5VHlNwNSnZlkFx7bmE05uhtVyviqRHgPJ8C5pjDji8v1BfpZC6s0qmiPc2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387630; c=relaxed/simple;
	bh=4tnLzSgoyH5Nmr+fmB4heyANSklWEBYDavEKVFkzKtE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZfnOVkbveZ+DUZff6ZB09t5n05Htk29dv+HbDIdSLoD+LfHYg7h/F8z2oyiGTQdgweNsl+XjR8HlNmYTRG4wFYXvERU+VzmtKcyQ6ZB3rbQ/gnf8gt4M5H9oSA/eh2NlqN0yvoo2WF4gQco8wePRz20C+TRdyWGg36XxazkQqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eLBG8Dh5; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eLBG8Dh5"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cce50dfb4so4773179fac.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757387627; x=1757992427; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4tnLzSgoyH5Nmr+fmB4heyANSklWEBYDavEKVFkzKtE=;
        b=eLBG8Dh5uERujYNt/ml0iVxFMY1RccYTVZUxEe01BRBgQSnexDuKZLtHreMNcxZtsO
         HmQQj+kkoDTtpyiLqmhu7thk8u9JNAHW753FKp+STG6Byg2cm19ljvdhxHNEpUBWo04i
         K9Gmyq51nguS5A8Fpcqeca147ic+uoXlPV/SyA9hlCMHKWLDdLEqKm5qQP6xxLyB0cMC
         /0yMWQaXPD3VjDG9jxtrCuu09Ip+VIzwhmGQCOnuS1baddIE/SVYnevLdzyR5RfdbVfk
         y17OsUz4LuZ+lP6wSAEjQ6dfezKpHRnwAR0Vj75YiVxsT1eSWhxM1J9UphFf2PVvcEnL
         cjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757387627; x=1757992427;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tnLzSgoyH5Nmr+fmB4heyANSklWEBYDavEKVFkzKtE=;
        b=sSrSp2WbyO81jKathMBZsqAWgLYHghB/oB2FK95ITywRfM4cpOkZUrAkVzkgqer+ov
         TL6gbCxdMYCeH1LRFNOFwM76JIuHH8/PMJlU2x5B1GQ7B8U2yY7pwjHshV4C/RP9ODux
         G5SdHCCRBWwXB78eRzep3lxDARloL7779jc4P4iXqiok6G40s4ysS1Ys1YWZhDDJ3oYH
         O1TO6Xt0iG5fybyiQpBJ3YsVXbiUuVoRvTRIgrgzPB0eslisk08yrSC2tTZxocH+TYTk
         18CLxNjF8RjWn74iw3oKiqW/Gu+ihNKBOk4BFtaqT3OjdztFHiRR6oN+y3kmuwMn9GNg
         FE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSu/604v7PyUKle1/lTkanHCGbLsjeIqylvVIcVpf4aoVyrFX0NKmPspj6kT2lAD7f8VikEMCeUEUjGrRCWJNc@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzvYsvjeEcGi86gTaMTgE21guso3vaxfJZWvinzR/nSv4RxyI
	wfZUnIWPRoZabLTwGeFGz+yDvQLMVoDYIKPqh896/li5pWPHYLjgv/slCDfBe087Oo1qsDnC5Kp
	Z47uvVgl+ON7piHsPjvN2JGw4D11d2TBRJ61Q4mFv+w==
X-Gm-Gg: ASbGncvobg6qVqO5nGRUE4v8eI1OxLdaUrjC9aDWbVhDean/Qu9V1wZFwCdlv4iIMJp
	v0jyOPaGcHDkTdZhWN7rpbgxguQZaNXzG5qWpvU+etdB+t+cEh1FiR8m6XjkRc8oJ1ZHPEnlzQQ
	p0WBaXFh6cn54zW3wddAIdhgL9O2Q6BhkOjVqOxeBwgp3D7J1+lUdPyr835t2fj9SmdHZ0ySKNG
	2VpKPjcMNeqciQom5ajIhRtr16G5eE=
X-Google-Smtp-Source: AGHT+IEjRnKVoKvFFA+E6GmCVRCB5SlIscn/ZuyjOxoBfVf+jCSOBjaZ+L0Ztd/wOGk5yQEwow86CDzdQXH1tpXYsRo=
X-Received: by 2002:a05:6870:9713:b0:321:2680:2f82 with SMTP id
 586e51a60fabf-32262955201mr4819276fac.1.1757387627362; Mon, 08 Sep 2025
 20:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 9 Sep 2025 11:13:35 +0800
X-Gm-Features: Ac12FXyRlupJTj4FkuA2woE2fvmmsdddZIrbELQIbDuD4dgkvkFHAjvltNE7XBA
Message-ID: <CAEEQ3wmjRuC-Z1PRTw1chP40KXFksBgHu+dayjYA9KXE9Q0Cmw@mail.gmail.com>
Subject: [REPORT] Should rdcycle be deprecated?
To: atish.patra@linux.dev, Anup Patel <anup@brainfault.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, 
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

1. To use rdcycle in user mode, one must first go through
perf_user_access. However, in reality, the return value of rdcycle
remains unchanged. This is because SBI_PMU_CY_IR_MASK in SBI includes
the bit corresponding to "cycle", and the kernel's pmu_sbi_stop_all()
function disables the counting of cycles.

2. Currently, some application software (e.g., DPDK) uses the rdcycle
instruction. In fact, rdcycle is affected by WFI (Wait for Interrupt)
and CPU frequency variations.

3. Some applications mainly run on server CPUs. Therefore, the
precision design of rdtime should be higher. For example, the TSC
(Time-Stamp Counter) of x86 architectures is generally around 2 GHz,
which can meet the application's requirements for timestamp precision.

4. What are the future plans for rdcycle?

Thanks,
Yunhui
