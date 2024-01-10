Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04713802
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5ntrZYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7660FC433C7;
	Wed, 10 Jan 2024 01:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704848693;
	bh=OcSWGdGo+aFNghErV/Rabu7S6Pbz+8TMSwFtlZ7IPeg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=I5ntrZYrCcJn9o2qpYnXFFt/X3vdyLiM7XWoZ5CSo9aSQn0Ij0NpECMmYdYUNNPSh
	 9GcTDsG/BqXphAcFHcEmvSRjayhiRrMns4D5blNT5Ukq3T2mvUt2fmIz5Gi4a/KxPV
	 /MTQ5UvTCifoTieLzwTebx7lUSd7ZvHx72jwjy4LIpscJIicyMgO9adCnH1/Qkguoa
	 o1sYYxoC8zuR64lytf9UZreYoYsKn06kjCK5ZbwnJ/2lrKbbAMREDVFkHr2rxa5E4g
	 YiYYY4j77naLaX5Ldc5v0Dg84QsC2sZqZZqtiNRy1OFATiTzrfdjJf1g5cJ3RS+xAF
	 Dv1LSLyTibDwA==
Date: Tue, 09 Jan 2024 17:04:54 -0800
From: Kees Cook <kees@kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC: linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Getting PMU stats on specific syscalls
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+JHD90kw0CX9=E18A7NBJrxdPDQuwrew355RV47oBhn_1s_QQ@mail.gmail.com>
References: <202401091452.B73E21B6C@keescook> <CA+JHD90kw0CX9=E18A7NBJrxdPDQuwrew355RV47oBhn_1s_QQ@mail.gmail.com>
Message-ID: <01A077C8-95CA-4EBC-9504-CB971C284547@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 9, 2024 3:30:32 PM PST, Arnaldo Carvalho de Melo <arnaldo=2Emel=
o@gmail=2Ecom> wrote:
>On Tue, Jan 9, 2024, 7:55 PM Kees Cook <keescook@chromium=2Eorg> wrote:
>
>> Hi,
>>
>> I'd like to get PMU stats only on specific syscalls=2E I haven't been a=
ble
>> to figure this out=2E i=2Ee=2E how do I run:
>>
>>         perf stat -e some_syscall_name_here make -j128
>>
>>
>>
>> Try with the technique described here:
>>
>
>https://www=2Espinics=2Enet/lists/linux-perf-users/msg09253=2Ehtml
>
>Using the syscalls:sys_enter_syscall_name and
>syscalls:sys_exit_syscall_name as on off switches=2E

Yeah, I can get walk-clock time, but I'm trying to get much more detailed =
stats (cache hits, cycle counts, etc)=2E

It seems I can only get PMU counts from a whole process=2E I was hoping to=
 avoid creating a synthetic workload that only exercises the one syscall an=
d instead get a view of the PMU counters under a real load but only for the=
 duration of the syscall=2E=2E=2E

--=20
Kees Cook
