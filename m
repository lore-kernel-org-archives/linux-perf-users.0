Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA222905;
	Wed, 17 Sep 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129228; cv=none; b=s0XUyNpPmmQBVgsmHVbsJgyXuX7qjmkvCnNf1mjJ71xrSe1GMBZCw/twD626I2tZS6hBfcQqpknqViwFPNDJNxB8Tm7Kqxvu7wKq7vEcsSBRF3ajejSaLdav+IOBsBBy4qThX6o1F3n+sJGASD558Od89cPp1sOzbhzmszEJLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129228; c=relaxed/simple;
	bh=7utd2mNCGqv0fGRGHJlqKBPLh/85qlOzgzSj3DRpfGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpB3UVBIRSfPBkNVI7SGuWywn3QjNrhN1oWvxuwMrCO4VBXl2Rm79lv1bNivzEZnpYnGJQ7z/qctJRCLw6mFK92I0wbbu06CZfyp9/nDREbPti5mhCS1+Jwi2TvBQEnpoZ8zSnHEw5KydvIdGMFm9iymZo7mS1wUAXk5fwQfMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s/8W4GJW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/8W4GJW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PWqxr35AzD9frV25voEqKDmiFYHwMk5p7VNBLNHixIU=; b=s/8W4GJWaIDo+n9p8W+SHHXkVl
	Fn6tiZ9I3k0bTLcNzUfK2eARfPMmb3YnFiGUjHNwBeDyPvfwpIH4T7eFh12E9epNABNHaniRiVGNZ
	faoJUG5fbaybuKgNChi4GfZRf9FNSfEwwI4OInG6x0/zDh56WpgrvMSYgAiecckuX56B6c299uQcI
	/N+oz9owL+iL4I7Bx/RnEvgduW/hyBfNrmY/I1eH40ahXsDyC/rL3HOSCXwXwA8Ty9QbAv6Qd2qlM
	IRp6eEtvkgeV+zfJ6mcNzn6eErXrAs4dyiDy/EfTp2b0nRC5TL2ASK1uXTsiqWCSlGcMSA06FGCTi
	NBmAeUvw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyvis-0000000DSn0-3zIx;
	Wed, 17 Sep 2025 17:13:38 +0000
Message-ID: <f8d432e0-e220-4857-8d4e-427332ce837a@infradead.org>
Date: Wed, 17 Sep 2025 10:13:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] tracing: wprobe: Add watchpoint probe event based
 on hardware breakpoint
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <175785897434.234168.6798590787777427098.stgit@devnote2>
 <175785898586.234168.14883193853242691280.stgit@devnote2>
 <014136d2-8599-4a1f-ab8e-c5be4f522e5a@infradead.org>
 <20250917233818.71678d0164a6fc2d11fa6e38@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250917233818.71678d0164a6fc2d11fa6e38@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 7:38 AM, Masami Hiramatsu (Google) wrote:
>> +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> +  #              | |         |   |||||     |         |
>> +           <idle>-0       [000] d.Z1.  717.026259: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
>> +           <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
>> +
>> +You can see the code which writes to `jiffies` is `do_timer()`.
> I'm having trouble getting from tick_do_update_jiffies64+0xbe/0x130,
> which I expect is
> 	jiffies_64 += ticks;
> in that function, over to do_timer(), which also updates jiffies_64,
> but is not called by tick_do_update_jiffies64(). AFAICT, there are
> no calls to do_timer() in the file (kernel/time/tick-sched.c).
> 
> Can you explain, please?

Let me try this again.

I understand the stack (call) trace/dump and your explanation, but
then your next comment says:

+You can see the code which writes to `jiffies` is `do_timer()`.

Does that need to be corrected?

thanks.
-- 
~Randy

