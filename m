Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793274912;
	b=VrAWpubKDVTDjtNJGg2kvJytodhjsYuWwB3Ab5YwcdP375eC1vCrRemgJHTq+cYTVQ3W
	 PISHl7OetOUqvt7fv2ZKeKG8IinWTPMw5v0WSu0YAgqgW54S7QSuo9wj4pVZcuCvo2A/s
	 /fnTjkyRl6UzN+qucXchDbG06khBxx4/bpb8uetD5+fNlbq4sopBPNTHLel53KoMsZVlq
	 GxYIaNjs8pKaH0VQ5yAP1B2UruiXJfsLORQMU+0vDtiWgXOajZ4iw6n1Ya3d7RvCzRe3t
	 L7XbXKjGjJCjBv3x0Wd6vEyCi794XIdLgYUiD9rBGsPxt5sABpMqd4YREqI8oyJxBMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Original-From:References:In-Reply-To:From:Mime-Version:
	 User-Agent:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=3VY7aUW6rjKEecWzoHgMRcesnfYCNorLy5OBPK7xTbg=;
	b=aad05Xvogxii5XwxJcOgTwqJ0u0csE0khJL3Beu/jnxz+lC13CSIKICFGqoRW4ytzIrF
	 TsNwYzoNuwDU5GYTMhw6i0L+9HSsTAhOKnhxWHSrgPCryRv4JYm5NndeuCq/lDBn3BYvj
	 bMssZnLDH47iAV7/94uCaRIEfkj9Kc0HYOpccyMP8BeB800Umn15xpts19WFnCtDTLDPD
	 +qqLsdkTrfrSsCwc1vvPAmBgbgIlnKkvl6Ddb9mjQNJpjdaLwFX8sOmtaqzEoEeGwFrPG
	 9QLW0yTvBngvt7DDuCSZZENnhuUt80P25GJsGxacGCPBBzJ9z33Dz4Nk2gqGIPhcVOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CuuMj9g2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92942606A323
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 11:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92942606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CuuMj9g2
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bfa686881fso1719519e87.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793274910; cv=none;
        d=google.com; s=arc-20260327;
        b=s6RGry41gZCIb12C9GkT3iOe8aOgxRCYzhmgmuE8+jRVIj0uXN5m1Q61hJg+FhKHMS
         Ze+rdvbQJlEtZdBy7/GrOrRhdXKANf5mmkUKFT6Zq1jyEJhJtRKvd5D00PegRMPZ549G
         0NqGUOz9SWMuwINXNBRiNqAllOI3XLqWWAHt0e8Ay1+rzzTS7aOulC1x73NJhqvhiEp/
         GtqRn63DqF0ZsglK1TBpKGsr6dXy6XGYC3xZosX+vpIpkiFlelgyNAUUbwBBF4i6zaBd
         7CyuAlFGmoZG0bXNWjUPCBab/87wZ1Ce9kWJHzrTZy1ofBjUH7CxM2MeFXXvxVpVpDtA
         FG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:user-agent:mime-version:from
         :in-reply-to:references:dkim-signature;
        bh=3VY7aUW6rjKEecWzoHgMRcesnfYCNorLy5OBPK7xTbg=;
        fh=OYSdT84PcFaQMqmSRNZ0FFhA3AIfv3TxVzCh7k2nd4U=;
        b=nY15fqTH4PxLh0fNjSiNOBltzTBb0h9mwfw88x4Z7N6yvvkIKHinzA1F4qeixgsKBk
         WgVPqA+jgygrrftz37hSGRyVKwUjWSUCnPpKygdocFcZv+MuoyLA6cqwanZsXtjpuuOo
         SJf/6DadvmPl6hS3lN22YTYelraFxe24ef5oWiBpXsKfRyIX308Sv36e58hdSGQ9lOTs
         jIJO1vnJYsuaSxD8L9OpgBJ3jBFhfBC1vGh0HbdxhyZMTmuQmaQqrA9UdA9q1FftqcyV
         dG38ZCvXoawjNXVWyF+0+EztJpHhlvWGHe4d0lJd8fls61Dc2rm+9ZQbqW6PAPfAM80j
         kQRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793274910; x=1793879710; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:user-agent:mime-version
         :from:in-reply-to:references:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3VY7aUW6rjKEecWzoHgMRcesnfYCNorLy5OBPK7xTbg=;
        b=CuuMj9g2Ph+v1MKWI7x/Ma1dHL0Yr4KokjmTvuzJuVaafCQww2WgpuyLSHPlgWCcD/
         +Gk+X8VA79TI3jaY6nC6/lgeOAgqapOhP0c8xZPuPpkSYomeOdNEBwQni95Grcwd84fk
         0zgQpy67pQE35kAeiaEWruBgLx52yWqsp3rGJqwcEiJRwTDz4zDYRzRbxk9SEsvxX5lS
         7m8CGcZU0pOzrhooYnyOmP3atBJQ+M78Uk59VVZtrrTUdGOndQtrAHVOH2KcLXppmQaf
         8uTqekRKs9XNH/7t1+8VISE0bfe3CZPTREigA+N8q68VSTgdF5IN3ggNxT9g9ztZTP0H
         pojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274910; x=1793879710;
        h=content-type:cc:to:subject:message-id:date:user-agent:mime-version
         :from:in-reply-to:references:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3VY7aUW6rjKEecWzoHgMRcesnfYCNorLy5OBPK7xTbg=;
        b=yo4lwPuPLAU84C9mbmAgXzbQDCNmQy1kuAmoc2BNCTz+vlr7EOjmwMIQdvo7ErnIjX
         C2G6O849gmfIDTPQglkOnz1/WVzs7GAX5woMPko7YkF4q3eOiL6YmmDho9cPbi3IokCN
         YN+U1qjezq48zUCBx5mq7fsqdCG/7MyUnq6vjMBSxMvL32fd4hllzWY4I0IWNOQV87ZE
         e9vBi49fza9WDIJjc9uR5XWiAzyMrF2Kys/TQBdWRJV2nakjy6441Gj81nIIerM0CNLO
         NxPvjP1xfeZvzk9fOxF9lKwyavFa4HqH8RE7aBXMgdlkc40lyyPcYAJASm7N4bsJPrgN
         UfwA==
X-Forwarded-Encrypted: i=1; AKwUvBxKWZ4bjLSYrnW4JmzAmPSEM6n6Cr0WT+Eed4EIXlGQ8A1YBI4fZ7i2E850wUIagfmOC5zc12TEtHo1/pb33gp1@vger.kernel.org
X-Gm-Message-State: AFq9FYIcXWitg02Mf+9RfPbeg6ZUH8xh9El90HkOfzLjtDIEwAVsDH2g
	VZQSf8G8WjjHyvro05Ig2yR2jYbDIkF2tEYEBcwdF+b/qQ0KfBK/AGkrVdVajxz3nEDbOT2GcIi
	D/ZCuBDnDetyfNV4HvXYxvEMn6xNxOWoUAcxwN5qxcQ==
X-Gm-Gg: AYBFou0lZ2378Kneow/xiVcAgsYRYZhopPZ05e3eU7pYyOFUBPtqiS3abdN91grTJHQ
	QqET678ViFgZaqpWpiPna0jhCKBSoMvVdpcLIBPEYisyc9CaqU1ottyeq3XIQ1kaq+NHx4qTR9a
	v/Mh5j6gv3m2egBnC6rJE3i32J6cqL0J8HDashnDQHbvQkytOSRsGYIiGDXC9+zZCuI15MOy2DB
	tJFuBTEvw2YcjsYaRLhv6wcUN20JmCsKOe82OrJ9QTfuWTfOUjJuZ0g0D6FQYGZtiYyk6BmG3Y3
	3iHoMdX8I+WH6iJIAL8rzn60cqJt1T0kiCVbPB1yht1/i6lM1LT/Rk94oFRzGC2BnXqUV3A045S
	0v6RSgHAbeny3Wlq6BzDDydCEzCNFlokJs+uasQ==
X-Received: by 2002:a05:6512:1592:b0:5bf:a209:f81f with SMTP id
 2adb3069b0e04-5bfcad27d03mr1811204e87.37.1793274909843; Thu, 29 Oct 2026
 04:55:09 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 29 Oct 2026 06:55:08 -0500
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 29 Oct 2026 06:55:08 -0500
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com> <CA+Ht8=YtrKJxr7YLO2z1389NPDnws8hSppAzVnYYJp5K1duvOw@mail.gmail.com>
In-Reply-To: <CA+Ht8=YtrKJxr7YLO2z1389NPDnws8hSppAzVnYYJp5K1duvOw@mail.gmail.com>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Date: Thu, 29 Oct 2026 06:55:08 -0500
X-Gm-Features: AclHuK9_AGd24eF3VOAo28szXNgJA0RFlLmIywua3jpx-rZ6jgflVyqTuZQeovM
Message-ID: <CACnXVncN5yT7Dmqom6m1SaFO0_MjXeoScTRfGUZ4RVdZKhAnHw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v12 00/11] riscv: add SBI Supervisor
 Software Events support
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
	Anup Patel <anup.patel@oss.qualcomm.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Atish Patra <atish.patra@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, yuanzhu@bytedance.com, yang.yicong@picoheart.com, 
	yang.susheng@zte.com.cn, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Himanshu,

On 10/29/26 7:38 PM, Himanshu Chauhan wrote:
> Hi Zhanpeng,
>
>> [PATCH v12 00/11] riscv: add SBI Supervisor Software Events support
>
> I See only 8 patches out of 11.
Oops, I ran into a Gmail smtp system error. I've resent the last 3 patches.

Thanks,
Zhanpeng
