Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146845;
	b=3vi7QYGBrvf35xw3EUlEoASJaS9jHXilzAwPEs5qohIRPhSZ8BcA7eK104kjgAZsuVMa
	 ZmOoVj5sqaWa5BKHHdJ76TRPZEjIdulJe7fFwG++R4p3ksHgE/pouvjaFtuKbnw9zYxUt
	 ZhTF2nCmaIxT06QMlk33uoYVk96t/7Cay1f2OEdaW+zTf/czRVNn1un927Pph6MqEvstj
	 Sf1bupSyRCzv2+TcsDLbWS6/T1EHh5+PtobxJf/wJCFgeDctx91ccK6bCeukhHlWp6QuL
	 BSbBCpqZN3+doyuf3/r2q5sfnaPfcwRnCgx0dLz6ySGpugnBT1cC74GlYMVQolbxwtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146845;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=yLh1qpirJEH9JAr3Gu9ETGq55dcbgI7wdDSoOW7XajA=;
	b=ImhuxsfmTc7WhSypmfxp7o3Y6BuOrPH/TJ9bwvIwOBQZ+YieRhNdHzNAYbES2X+TbLDT
	 BFTJj/OHp/lK2sCkDmmY2pXgEVgDqZEldVtftqT9F9Ugiw10wwdvL6Wi9b0HtllB6QZM8
	 RVGLZWe4O549IT8slLwk2ufuLJQSQ5F1IS7um5mbVgq+r2Ugrqopdxgq+cE5gGmhPP31i
	 uIANiByNj4wtyL3y2/qGcpbymkA/YAKC4c7K7pyBUYlDpbdxmGZmMFKtxPWMpCiPcAclA
	 HW7cONmnPTL4GEpKlQFTPrMfgoqhtClviPCLY9ROFjgAMJb9bps4AuiywjOm2r02YSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KroRQOmg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4BF606A320;
	Fri, 20 Nov 2026 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KroRQOmg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7B21F000CA;
	Fri, 20 Nov 2026 03:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795146844;
	bh=yLh1qpirJEH9JAr3Gu9ETGq55dcbgI7wdDSoOW7XajA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KroRQOmgch4TTDvUmHjnyxBg3GWS89v43pWDscHsrFN7OatiF9yHupLTL/msWLZ2a
	 NvOHh2GoTS5itJ2hG7LDa0zzMfRmXZFdmvMGqP85py24jQ5znxfrYmYsVA/4m6ulRJ
	 VSlFKM7R49l+iSD/Oa05XXdinpsN8LAu5rQvGGtIEk7Cm/7kWO67jdl34yDaKeoG2C
	 fl7uUUaW8UQwg4BR+rtJibZXkWAZfKvH0oB6zM08MQsvAcUBvYva5/y/9b2OasbIlp
	 735ZrTHqGNYtYqdwjsQZ/OUHccmGlS2xWprUSFM7egQ/epHwO6t+fnfEkmOQVkDqxy
	 5VyE5M+lhlxQQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261111-tp-glob-errno-v2-1-ca45efb07d31@gmail.com>
References: <20261111-tp-glob-errno-v2-1-ca45efb07d31@gmail.com>
Subject: Re: [PATCH v2] perf parse-events: Don't report unreadable
 tracepoint globs as unknown
Message-Id: <179514684340.638421.18332137800214715331.b4-ty@b4>
Date: Thu, 19 Nov 2026 19:54:03 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 11 Nov 2026 09:48:50 +0800, Hang Zhengyang wrote:
> As a normal user, a tracepoint glob gets the wrong error:
> 
>   $ perf stat -e 'syscalls:*' true
>   event syntax error: 'syscalls:*'
>                        \___ unknown tracepoint
> 
>   Error:  File /sys/kernel/tracing//events/syscalls/* not found.
>   Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this feature?.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


