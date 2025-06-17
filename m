Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ECE2ECE99;
	Tue, 17 Jun 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175416; cv=none; b=g1/id2z/YhpDTCUT4NeDdWpNJqred1eTvn8lw0P1XSo1jW4l0BCBtdwbE+3z6o84IGPo1tMCsFAZhq6j2nZLIZxd4JcqBpZKONpBC2Kf/0OgR2+cv7Jk9yXcTmF081gDfYIa77g7RjBH57Pqv5YHkTCh1Vq8rlmvEELmCy/2YlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175416; c=relaxed/simple;
	bh=sQUR3wj1GLJjyLrPyEj1zSMJgcPH/Jb28IWEOYVQa0E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SRIaWdCg0rjpODkFVyHL4fKlUmCjA62nTvOpuGLlznvwcwTLweSIdBJ7Ad3ShCD0+1imQyeLAhjAhKX+HsfPYmm0ChAho98VhulfaJRBfuRs2qqHSXcXrDUO2L62KsbtIurlmDuvAeWMuRj9Id8F17xHyhqm4jDkAjVMYz9AMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTx+fPgq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTx+fPgq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso4680136a91.3;
        Tue, 17 Jun 2025 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750175414; x=1750780214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/8BjRQTbTLXO4efQmkPOb9g/rZijb4u6NSdRQHT66tg=;
        b=JTx+fPgqFt6W04485Ax63S/KxDofvC5qvNDdpQxH61yTxy5zQ7zVEk8ytkK62n1ulx
         ashqW2B92q4mxsPtYjxVLfJuS1kL2vR874+26SwI3+C7oLVI7WRQ/L1sWZwDRZBGthJf
         3dNJGy9Th6il87bv+IB11CQ/K5Ww8zgBiWYz8kuXps/0VnTsWAkqZHxiN/+FGNI59pkj
         B6sKB3YtoQiu0vfOCBA+FbC4k1vb+0p2NAkcJJ5Xh84ySAK+3rabCBNwPYDNYn8UJzwU
         XE0mzugVqMIUoR8CIK2nLSyhI5GtvVmBZ8T5NwT3zH553tRVTuXvFE5i1iqm6rjIv3br
         fPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175414; x=1750780214;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8BjRQTbTLXO4efQmkPOb9g/rZijb4u6NSdRQHT66tg=;
        b=OvsYw/rCsIE1vseDGeyDmd8IOhD+XuljVCPDoqDWq/ZhyONTazofP8Vcx7yATgYaMS
         zZLSiGr8al9MVQGP5+P2idsdRPb7lg2MnQajdr48xS7K6+s+hjcmsMiwpImx6oDpt6E2
         TpAcc3MLisKKe2I0UZt7cxz0OAyAFqEFlat4FLdApJ0q0762Suk08Pvb3sRbMijRGgsJ
         /xalhE+dGOwVRiwAGCUqkPVGqpwh5RS5IjmVMBRUjHtrZ0bIalV4gmzeBQZFXNyNnSFs
         Fmz4UYJxC7TjXlQeoalvK0jE60CJjlX8J57ePmma74gRhwJLn4LUXTpqp7T9sYTwQ4Am
         iQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCWo02ZOLft5mhH1UnfPoAVfJT81d6yghIueS7C+mEBYYW/AantJX8QpBDeYV4oRTpJOq899eLQDQLP9IRpCYj7/@vger.kernel.org
X-Gm-Message-State: AOJu0YwvcB0eqo27tW1/wlcbmajTMLy5uloAa9v5qkxo7xrORtSSvvol
	ieaci/ht+Ofp7lilWKjvqWOJ5oEyFgjmEJxHtuPeOgNmjvU0VRklDrI1AUr9UQ==
X-Gm-Gg: ASbGncs8leb7uf+Qz8RwzAMRUYve2Wi1ps1RqAlmt5GIpmGUMoBtfK1UQME75lriMSM
	APTskcPY3HAL3s4sqa9lRHRJE5fGyctz7vO1jGan3AxED5ihjQZzq15vZKtkMTMBzAPtHrjrny0
	V2Jq4+gklnuwD7Vm2I4AIHsveq3qlG8i3JBqJdYJ1JHuknnPkQ65dNX2I4CZjTdz0UVtVi+/C4T
	BIUSaGb2Z0URXKecjtbuQVufdDrOE0iiaM3+4wTALez0lJJmNRYR7LLbcTVjn4ecPF+C7llwjSA
	BMvWkF16RO4Pe9e0BnAse5ULhoUO4FbLNcILYR72faN8fSWHghfUj798/hNuxnMKbtx07vo=
X-Google-Smtp-Source: AGHT+IE2SUZCziltGWP41uV/6AVJMUmfB9j3FNze1Bjcvn4EHiwNf3s+mbjnZ9Zj06V5bmarXFHdVg==
X-Received: by 2002:a17:90b:1f8d:b0:312:db8:dbdd with SMTP id 98e67ed59e1d1-313f1ce3cbbmr20240405a91.28.1750175414272;
        Tue, 17 Jun 2025 08:50:14 -0700 (PDT)
Received: from ?IPv6:::1? ([2405:201:900e:b1b1:7db9:b6b5:b232:fcae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c5fef6sm12168541a91.40.2025.06.17.08.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:50:14 -0700 (PDT)
Date: Tue, 17 Jun 2025 21:20:09 +0530
From: Abhigyan ghosh <zscript.team.zs@gmail.com>
To: Vince Weaver <vincent.weaver@maine.edu>
CC: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
User-Agent: K-9 Mail for Android
In-Reply-To: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu>
Message-ID: <328B9E3D-E0B0-44C6-8574-27302F33A638@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Vince,

Thanks for sharing the report=2E

The WRMSR to 0x3f1 stood out =E2=80=94 seems similar to the one handled in=
 commit 2dc0572f2cef back in 2021=2E Curious if 0x3f1 has popped up before =
or if this could be a new MSR usage pattern tied to recent PEBS changes?

Also, do you think a quirk-based mask or trap filter around this could be =
a cleaner way to handle this in the fuzzer context, especially for newer In=
tel platforms?

Let me know your thoughts=2E

Best, =20
Abhigyan Ghosh

On 17 June 2025 9:09:36=E2=80=AFpm IST, Vince Weaver <vincent=2Eweaver@mai=
ne=2Eedu> wrote:
>Hello
>
>When running the perf_fuzzzer on a raptor-lake machine I get a
>	unchecked MSR access error: WRMSR to 0x3f1
>error (see below)=2E
>
>A similar message happened before back in 2021 and was fixed in
>commit 2dc0572f2cef87425147658698dce2600b799bd3 so not sure if this is th=
e=20
>same problem or something new=2E
>
>Vince Weaver
>vincent=2Eweaver@maine=2Eedu
>
>[12646=2E001692] unchecked MSR access error: WRMSR to 0x3f1 (tried to wri=
te 0x0001000000000001) at rIP: 0xffffffffa98932af (native_write_msr+0xf/0x2=
0)
>[12646=2E001698] Call Trace:
>[12646=2E001700]  <TASK>
>[12646=2E001700]  intel_pmu_pebs_enable_all+0x2c/0x40
>[12646=2E001703]  intel_pmu_enable_all+0xe/0x20
>[12646=2E001705]  ctx_resched+0x227/0x280
>[12646=2E001708]  event_function+0x8f/0xd0
>[12646=2E001710]  ? __pfx___perf_event_enable+0x10/0x10
>[12646=2E001711]  remote_function+0x42/0x50
>[12646=2E001713]  ? __pfx_remote_function+0x10/0x10
>[12646=2E001714]  generic_exec_single+0x6d/0x130
>[12646=2E001715]  smp_call_function_single+0xee/0x140
>[12646=2E001716]  ? __pfx_remote_function+0x10/0x10
>[12646=2E001717]  event_function_call+0x9f/0x1c0
>[12646=2E001718]  ? __pfx___perf_event_enable+0x10/0x10
>[12646=2E001720]  ? __pfx_event_function+0x10/0x10
>[12646=2E001721]  perf_event_task_enable+0x7b/0x100
>[12646=2E001723]  __do_sys_prctl+0x56f/0xca0
>[12646=2E001725]  do_syscall_64+0x84/0x2f0
>[12646=2E001727]  ? exit_to_user_mode_loop+0xcd/0x120
>[12646=2E001729]  ? do_syscall_64+0x1ef/0x2f0
>[12646=2E001730]  ? try_to_wake_up+0x7e/0x640
>[12646=2E001732]  ? complete_signal+0x2e8/0x350
>[12646=2E001734]  ? __send_signal_locked+0x2e3/0x450
>[12646=2E001735]  ? send_signal_locked+0xb6/0x120
>[12646=2E001736]  ? do_send_sig_info+0x6e/0xc0
>[12646=2E001737]  ? kill_pid_info_type+0xa6/0xc0
>[12646=2E001738]  ? kill_something_info+0x167/0x1a0
>[12646=2E001739]  ? syscall_exit_work+0x132/0x140
>[12646=2E001740]  ? do_syscall_64+0xbc/0x2f0
>[12646=2E001741]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>[12646=2E001743] RIP: 0033:0x7efe86afd40d
>[12646=2E001744] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 18=
 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 9d 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 1b 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
>[12646=2E001745] RSP: 002b:00007ffcd6444cf0 EFLAGS: 00000246 ORIG_RAX: 00=
0000000000009d
>[12646=2E001746] RAX: ffffffffffffffda RBX: 000000000000000e RCX: 00007ef=
e86afd40d
>[12646=2E001747] RDX: 0000000000000001 RSI: 00007ffcd6444d24 RDI: 0000000=
000000020
>[12646=2E001747] RBP: 00007ffcd6444d60 R08: 00007efe86bc625c R09: 00007ef=
e86bc6260
>[12646=2E001748] R10: 00007efe86bc6250 R11: 0000000000000246 R12: 0000000=
000000000
>[12646=2E001748] R13: 00007ffcd64471b8 R14: 0000559eb2a2edd8 R15: 00007ef=
e86c30020
>[12646=2E001749]  </TASK>
>
>

aghosh
