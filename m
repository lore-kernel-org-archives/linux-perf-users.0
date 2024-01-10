Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512838D
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkaJLlvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F794C433F1;
	Wed, 10 Jan 2024 01:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704848518;
	bh=b9eGHhUvMPhk7bbDYIZW9T/sdR/i+F3q1dwzJYCXJWw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EkaJLlvTWQoN9UHyCAwRUQkypROdNe9HEONwhRLbZK4qR9y84JQZ6zD/upiO3BI3M
	 6YiXL/UkWjW9HdHw4A/WBEAfLJvlqtzo+dPj9WseCEvLZ9LRebRFXInYPdZPBA6uzl
	 WiaGrYQiasP3ljQecZfbCvhjGs3smziC0vDLvYIfeNTgI6JB3BKJHgIsMjvFM6yXZG
	 KEW+l/yj65Htn7m0thJqUPFXMmig6yfwu6AnEBqcXcuphkXbiEr316NfhGvY1koSF2
	 CnxwjfaI5w+66LgwXEQPZ7JlP/VNZAco/wUBy+AMfnyBwKxIS+0+/Z0ldFuq4PJSJy
	 yi3F5i2MHq3Ew==
Date: Tue, 09 Jan 2024 17:01:59 -0800
From: Kees Cook <kees@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
CC: linux-perf-users@vger.kernel.org
Subject: Re: Getting PMU stats on specific syscalls
User-Agent: K-9 Mail for Android
In-Reply-To: <CAM9d7cjBTw0RDv1LKNuiHZgTivW+jjnrtmWjm9Z4ekspWtYmrw@mail.gmail.com>
References: <202401091452.B73E21B6C@keescook> <CAM9d7cjBTw0RDv1LKNuiHZgTivW+jjnrtmWjm9Z4ekspWtYmrw@mail.gmail.com>
Message-ID: <7CD8ADB1-7BAF-4BAD-A8C5-285BC148E691@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 9, 2024 3:52:53 PM PST, Namhyung Kim <namhyung@kernel=2Eorg> wr=
ote:
>Hello,
>
>On Tue, Jan 9, 2024 at 2:56=E2=80=AFPM Kees Cook <keescook@chromium=2Eorg=
> wrote:
>>
>> Hi,
>>
>> I'd like to get PMU stats only on specific syscalls=2E I haven't been a=
ble
>> to figure this out=2E i=2Ee=2E how do I run:
>>
>>         perf stat -e some_syscall_name_here make -j128
>
>How about this?
>
>  perf stat -e syscalls:sys_enter_<syscall_name> -- make -j128

Unfortunately this is just a count of calls=2E

>
>>
>> I can't figure out how to limit collection to only time spent during th=
e
>> syscall I'm interested in=2E I tried building synthetic events, but tha=
t
>> doesn't seem to work=2E=2E=2E
>
>Hmm=2E=2E ok=2E  it seems you want to use PMU only for a syscall=2E
>I don't think perf supports that for now, but maybe it's possible
>to attach custom BPF programs to read perf counters at syscall
>enter and exit and to save the diff in a map=2E

Does BPF have access to the PMU counters? I don't know how to even approac=
h writing that though=2E :P

--=20
Kees Cook
