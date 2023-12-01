Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 503E4199F
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 01:57:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899D01042;
	Fri,  1 Dec 2023 01:57:54 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 821383F5A1;
	Fri,  1 Dec 2023 01:57:07 -0800 (PST)
Message-ID: <d5067ea9-ecf6-5c5d-5ffe-7590671e7f6d@arm.com>
Date: Fri, 1 Dec 2023 09:57:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Perf support in CPython
Content-Language: en-US
To: Ian Rogers <irogers@google.com>,
 Pablo Galindo Salgado <pablogsal@gmail.com>
Cc: linux-perf-users@vger.kernel.org
References: <CAFjbc8G+q4sFpO5D6PqbDFNbHHpgYZ_2ADV7sUp7Lw=AefprJA@mail.gmail.com>
 <896b5786-8ed7-af6c-2c64-a24bb06a0d89@arm.com>
 <CAFjbc8FXJwJShr88XUybWFQa1HC6rYdq7cpc3XPCuPKjOUoz2g@mail.gmail.com>
 <CAP-5=fWZORMTvqjz5SrH_6sJZ=7APf7VpeL7HZkmQvUH4j88Ng@mail.gmail.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWZORMTvqjz5SrH_6sJZ=7APf7VpeL7HZkmQvUH4j88Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/11/2023 21:16, Ian Rogers wrote:
> On Thu, Nov 30, 2023 at 4:42 AM Pablo Galindo Salgado
> <pablogsal@gmail.com> wrote:
>>
>>> Do you really want to use full Dwarf mode? You have to save the entire
>>> stack space on every sample for that to work, so it seems a bit slow.
>>> But maybe it's not an issue for lower sampling frequencies. If the
>>> application has a huge stack it's not really scalable.
>>> Is that just so you have a mode that works out of the box without any
>>> recompilation of Python? But not necessarily the best way to do it?
>>
>> I do not *want* to do it as we already have a fully working version
>> when frame pointers are included
>> using the perf maps version. But the problem is that users cannot
>> generally leverage this as most
>> Python redistributors do not compile with frame pointers, and this
>> renders the integration useless
>> for most people.
>>
>> So indeed, as you mention dwarf unwinding is a suboptimal way but it
>> will provide a way
>> for most users to get the integration working for them and people that
>> really care about the
>> most performant way can compile Python with frame pointers. The
>> problem is that most
>> Python users do not compile Python themselves and this is a huge
>> barrier for them.
>>
>> That's why we want to *also* have DWARF unwinding working, even if it
>> is suboptimal.
> 
> Won't fixing GCC/LLVM be the best approach? Change the RBP offsets to
> RSP relative ones if shorter, perhaps around this code:
> https://github.com/gcc-mirror/gcc/blob/master/gcc/emit-rtl.cc#L882
> https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/X86/X86FrameLowering.cpp#L2547
> 
> Nobody really expects 1 register to be worth 10% performance, so
> fixing a performance elephant (which by definition should be easy to
> see) in the compiler will win for everybody and give a solution that
> works with BPF, etc.
> 
> Thanks,
> Ian

I found this thread that's discussing why Python has such a big
performance issue with frame pointers relevant so I'll leave it here:
https://pagure.io/fesco/issue/2817#comment-826636
