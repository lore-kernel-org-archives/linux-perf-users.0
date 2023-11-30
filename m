Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFECB131
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 10:09:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44EBB1042;
	Thu, 30 Nov 2023 10:10:39 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36C533F6C4;
	Thu, 30 Nov 2023 10:09:52 -0800 (PST)
Message-ID: <c845d1f1-4463-7c00-e63b-b3c9968c600c@arm.com>
Date: Thu, 30 Nov 2023 18:09:51 +0000
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
To: Pablo Galindo Salgado <pablogsal@gmail.com>
Cc: linux-perf-users@vger.kernel.org
References: <CAFjbc8G+q4sFpO5D6PqbDFNbHHpgYZ_2ADV7sUp7Lw=AefprJA@mail.gmail.com>
 <896b5786-8ed7-af6c-2c64-a24bb06a0d89@arm.com>
 <CAFjbc8FXJwJShr88XUybWFQa1HC6rYdq7cpc3XPCuPKjOUoz2g@mail.gmail.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAFjbc8FXJwJShr88XUybWFQa1HC6rYdq7cpc3XPCuPKjOUoz2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/11/2023 12:42, Pablo Galindo Salgado wrote:
>> Do you really want to use full Dwarf mode? You have to save the entire
>> stack space on every sample for that to work, so it seems a bit slow.
>> But maybe it's not an issue for lower sampling frequencies. If the
>> application has a huge stack it's not really scalable.
>> Is that just so you have a mode that works out of the box without any
>> recompilation of Python? But not necessarily the best way to do it?
> 
> I do not *want* to do it as we already have a fully working version
> when frame pointers are included
> using the perf maps version. But the problem is that users cannot
> generally leverage this as most
> Python redistributors do not compile with frame pointers, and this
> renders the integration useless
> for most people.
> 
> So indeed, as you mention dwarf unwinding is a suboptimal way but it
> will provide a way
> for most users to get the integration working for them and people that
> really care about the
> most performant way can compile Python with frame pointers. The
> problem is that most
> Python users do not compile Python themselves and this is a huge
> barrier for them.
> 
> That's why we want to *also* have DWARF unwinding working, even if it
> is suboptimal.

Makes sense, it just makes me wonder if there isn't something that's low
overhead that could be added to the default build configuration of
Python that makes it work even in frame pointer mode. Like putting frame
pointers only in the trampolines.

If that doesn't work, maybe this is kind of a ridiculous idea, but what
if you compiled the final binary so that it had two versions of Python,
one with frame pointers and one without, and when you run "python -X
perf" it goes down the path with frame pointers on. Presumably the
performance hit isn't as big of a deal if it's only on for profiling.

I suppose everything is a tradeoff, and that trades fewer build
configurations for a larger binary size and more complicated build system.

Feel free to ignore me though, I'm just thinking out loud. But if Python
was already modified to insert the trampolines, it seems like there must
be some modification that can be done to make frame pointer unwinding
work without turning them on for every single performance critical function.
