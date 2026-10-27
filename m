Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068958;
	b=2H9gTbjDQenFKfv/219TF83PEs4vsdHKUKY/fz7QUKfa6Azv8/sCIo0HgYGX9flDvofo
	 pokrArDDDLKcpPNUr119EUdfl7eH0w99kNjqo6BEFc1EWQrWdzFWqvm6nzRRjPf0WGI3D
	 9Rg6CRQXjxZKql4Y4IOZOCZzWR4Mm5Z3+8pqoSif9/ip/NTRvshb7OSmr7SY6fHSZ+sGc
	 PlowCMUdP2y4eBsq8/GzxhA86ymho+vbE02HrClliPpsfQcG5hE2dOXx+nGSXt98j4N9u
	 asGSC0qXBX3+JlV+RmX5IKeYTh2Xwp/kve3mt2YWTmHC08G6eynjWdvTwRxZJ6J2MRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
	b=WAs/tUuWdovI21rEJt9lBAJGrPqRzS88w6LSKso0G9UgCHZyWulMskxaaz7n8m8lILqH
	 /QpiaPVim1FDOpHRXeUv7my4aX1C+ZOuijTOiGbwenmewzasHXjiupjHgObjeRwjzTi5j
	 ygaxFp68DLP3NcSlvQxO8VIpYMcZgRuItJEXhZGfuKYsz0d/8xM8cuZOwVNCEa579m/7V
	 91cWR6PlOjCE+q3eJnJDTPHkYl6+62QUYCNDuKEXPtcvRBvtGuakItvL7ClvvTV5FTV6z
	 nB2nn3z2lNgM7s27i6YeF6dutK+DsVRSWmsjybSTteE3xzcUW2kckqwKMVmcN9kooSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5479F606A31B
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 02:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5479F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1846bc43c28so4071750c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 19:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068957; x=1793673757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=nAMLJ4pov/UKnTCLgH305UyFiee1Kbb1n3tCzOl712VaepOkFQaBHOfe8TqG3p1lZU
         FcmqVqrrqUreTloBdzXh9C3S8RzvKdqK0Wdm3ymTtA2e7F8hg+g3tAXi0qMz5tjjKhfg
         XZsmI+gaR0xwl7nmIQiVOSWVXQuFdQ0nDSV/JTrdP8vh+zCmGEp4ByKhGzO7Q9EFAqG7
         Z9UxSRbzl1SyjYddPBfqeotnjUxiWUf5QMQHMI+2cHXwFS8e7Vcd6faApvoLAEI8hyVq
         H9p+0vB8HKXlTDO8gBcIdyEeUOqojMCpKudjjewsxrlbiMp0bSMq+X14CJGfZa/XuOHM
         djkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068957; x=1793673757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=TO+Gn6uJbEqUGageke9LDS/O4kkoa/2j0inaLe+ohiXdo+q7ctMgCpoh02nlKbH+ri
         EKKGOsvN7NymZhz66Ihzh3XmGr/IAA7FgwxKg2Sh641jCTDOrntxqx4Aun/qHYzsFUuN
         btqBcyLEXK070IHRy/UbZ6c4ZJFN9UF1qm6YM/Ewc3t3EmGs1nI9Y8147zaaFMiWjNy+
         wR79qrxEwwPzdLzWYshkkT3q51VJRYMtueGIlG1wq/UpY36khpEI7FFwZ6KsGO7v+HVb
         iwtGjylEkplfam/N+REE8n09jY3Cjk/dda5BkbdsOMb0khHlQ1MIDpjQ3qA2gO0vFYcG
         wbUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzql+YEinj/v5/6uVsJk65dRn3Jcee/E79XQBqLn5jhygaZSp4QSFKJpBSKKOtBrXAWnWvvSzxlofleQdx2OA2J@vger.kernel.org
X-Gm-Message-State: AFq9FYLjU0Xejl0w/BGhM2AV9A/iC4fdFa/ch6dkMBGdzjIEcOyU9IBH
	LgBLg68xQxntZod8p5AqdGz9rcYa/m2sbjbwve/muVWG6AsZob55+bOzlprjID0gRII=
X-Gm-Gg: AYBFou1Ja3DS8ex7e6Y8OaVmTp/SMUGT8fMVUoYm6OGihWz07Q/2oBExsfRdIZi7v9C
	a1FUkt/wyrhAtfwzbkBb5etbJq2panSe7tmIh0gviqbHM6L5Ij5nwfCKBXreh2mnIdzeEbzVATC
	LxF4/6FsZmlHj4Y/GKXxpQGXCIl10oRnaVU6Jua8ULm13MC7h+HTVTbmiZ3lNOUFpdw/VAiERKO
	2EFPqFImA8lUKljrKvArnCMQGBok9Ky8RgzKlauZr+lEhDCsRHNW8fNj/Ge7fn4tr3LsPgdEJQN
	AxVjEBfzhSyMVGbztjTJdNJwLY5CVNiG5qPCJ5XsRtPoGwvqXc0ECSkhAi/P85B/NxUFMSkQhN1
	FKJMz1si8rbCqiFU79mYoXVky9K8V3cEmIYUt8H5VZUCQfLlYnqUM3HpUkLbUFyleYgIEfwmb3s
	Q1t7YXlZIbfE0lfGGTZW4N7m0PCulRSQAqRvD86LHhHTA3OEyVv86EwS7RC8tgh2WhMmGUgL/fY
	t4xYeXZfVxjsLcYRrJP6jGgmrFBq8NEN0NvRzUIregahdL+5b/RzAUy06a6uGkJBMkzi+wBnx3V
	x4SZOT3bXl1ChCdMg/CMuYVEquDWrRPy1g/nQ88=
X-Received: by 2002:a05:701a:ca07:b0:144:fd7c:84fe with SMTP id a92af1059eb24-19937307669mr13761314c88.35.1793068957501;
        Mon, 26 Oct 2026 19:42:37 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm59514670c88.17.2026.10.26.19.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:42:36 -0700 (PDT)
Message-ID: <30b1cf28-61e6-4f28-8e28-79815bd87617@kernel.dk>
Date: Mon, 26 Oct 2026 20:42:35 -0600
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] btrfs: Don't copy encoded read data to user
 memory when canceled
To: James Houghton <jthoughton@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
 io-uring@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-btrfs@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-3-jthoughton@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261026215226.3713941-3-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

