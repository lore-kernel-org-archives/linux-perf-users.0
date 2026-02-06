Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD52E6116;
	Fri,  6 Feb 2026 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349430; cv=none; b=fj6bcCNwg2yyhB1SbNZlr1KMf+YgcueWpJr/HlVbFyBwHLL1lOX6U2inZda8S/HOZTBGIPWOt2sSW9UJqGK5XB8Z5tcsUDhps+0hrIWcgPQHFjzOJrcGyf++mkyqSIxMoYOiIdc03pDzdjLI6klRXYBMd4sBn6wvw+YoO+c0Q5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349430; c=relaxed/simple;
	bh=CpYn3Lmhwy+KIIrfqIsv0YXqk9uf6dCLHRdZyrulKPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ly1aJGiWbJZ87O3XIwFelJAUvye2G1o1ysdm9dE9th1Kaz+Z6MJDzckx1zCVFd1+tS0Pv1kpfcwSgW1dIMEk8c06CNkOj4iNPhB/8yFqW/74+x7VKMEwKWCGd4Nyce6pl1vZO+LxHNv8V3w9jvTfWbOdvzPMTgC7gIP8lnbIU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=oulkjrot; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="oulkjrot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770349365;
	bh=dKq7u7TVKmzLjYmab7Qq2COrl18pEr8pQsUYQyol7Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=oulkjrote9Q96y0/gmM+/DtP0XAyWj7VrXMUPyw6Gg9uhuo7r0NeM392AX0dVtpnT
	 KirAuW8TGxaVqUBF1I/4Swwuqxn4EBzLjUyskTetf23vxHYcaiPI6izzd+QkDIDnTK
	 lSRzTI1hhoUB4vXvCmSUy6ZdyfiiR2/A3gfgD9bM=
X-QQ-mid: esmtpsz11t1770349363t2f031b48
X-QQ-Originating-IP: uvLdIVcoRo1MHH/2UymnvA60Oq4oJs+mqA1/5VSDqh8=
Received: from [10.3.91.191] ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Feb 2026 11:42:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5996589195195940344
Message-ID: <752514AD54FA2A1B+513d6894-b3bf-44f3-bcc1-7d30f2642cc2@linux.spacemit.com>
Date: Fri, 6 Feb 2026 11:42:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance
 monitoring
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Zong Li <zong.li@sifive.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
 <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
 <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
 <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
 <zzbwkazzgeovgmbvg4qnibipzsldqcjnw4axnxlamhgvcld4hs@4m4cc2ctuuvf>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <zzbwkazzgeovgmbvg4qnibipzsldqcjnw4axnxlamhgvcld4hs@4m4cc2ctuuvf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: McJfg7Aee/FZyhhtIPyvEocNxm6JejMTUNCvzP1NZK3H2G1LD0Pp7/Vd
	3Um6+DiBhA6MIAO41u7NyxwenNjjMscjOkS3xLD+2QqaKpb1oWnsP7fpQqNN2VnjALLA0vd
	9BfMAWuPGou0j8W/Yeia6bK/hpF+yRe2n2jeSDbxwEpC4/FkQmnbpdohzX+EN3c8uW61azT
	AMQC1zR5k722Kb2R34A40Bxgfo9EKkHileELw/dfMYMexpydfwwxpd/sWcf8ZzzkEz9vT3Y
	RZjWZMGyzxhj/8jnl5cWrKCbGbGS2BBB6GUmohOtJgC93aSGtUAtFd1elzXfoX2Avom8E6/
	LIz89ALwmNAcPISVZu9qCk9gFTuwB5Xx6WmK7OMkIOsZxtuLjECOlUQw98/1xFjGawxyEJG
	p4amUc6eecTMP3y+gzwi4ZPC9wLyoZfhpUHQX9l6N5OHW3dBFJXc++lAbn3x//OYlYKfBvY
	+tKHMZ+6pb3pKu1wSA1bpPYd649EXL2rH0W9UQi9TPq3/f/Nfc5ZWI0STjX7maEOaGn4A2c
	wRsrX3txox0jvHFDtJr6853AIq0gDjBZdOfOpgOTzHnwuJhEziV3TlRBG8v++ncH3YQnvC7
	QtLOO48SSZL+PHVuaODU8Z5Hd4Bf3crn4xjSjbMm5NM1/LuPLZWA0oi3Hm+CpcOl1insyOp
	l9EyCDSv19jtQeUO9OUmH7G2l5pYEZXpoCD+I+7dHs3X4dsnCjG2PcKpBaFt9UqW7DY0v78
	rHYEAjydRoAnmMNp7xqNLiB61Vt/3xRLf0zNqupxYZJWLFJ1nskcxf1ECwX8lQYunxGAU4h
	C2ou4vsD9z59wjkSRRKtqUNCMnVpgxmle248czo/tFjjKjmdJAhdnn7ib+GZ4oPkgI1BztQ
	am3MH7YNN/YWZTCjGrbQdMqxlrfXEVzDUs9Tl8PwkqIAp+YZBAwbP0J/9AGZYwYly5V1iq/
	57D7HmfyaHvBQWHKDH+YZvHze2X2hRXWyYfhDLwnF4HKbtvDw1v2OCvGaxH8wJBeeIj3gqU
	a0v7F2Ib1ucUNuvEz3W18nheU5W4lxGkcrN103kh0U9Vubi0HM
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On 2/5/2026 11:23 PM, Andrew Jones wrote:
> On Thu, Feb 05, 2026 at 02:11:48PM +0800, Lv Zheng wrote:
>> On 2/5/2026 11:47 AM, Zong Li wrote:
>>> On Thu, Feb 5, 2026 at 11:35 AM Lv Zheng <lv.zheng@linux.spacemit.com> wrote:
>>>>
>>>> On 2/5/2026 2:39 AM, Andrew Jones wrote:
>>>>> How does this relate to
>>>>>
>>>>> https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
>>>>>
>>>>>    From a quick skim it looks like there's plenty of overlap.
>>>>
>>>> We developed the driver in 2024 and demonstrated it in China summit. We
>>>> didn't notice that a patch is on-going now in the community.
>>>>
>>>> Now it looks our approach solved more issues, and we'll check and update
>>>> if there are any community concerns still not addressed in this patchset.
>>>>
>>>> We can add Reviewed-by/Tested-by and Signed-off-by of Zong Li to this
>>>> patch if he wishes.
>>>>
>>>> Thanks,
>>>> Lv
>>>>
>>>
>>> Perhaps I can first post my next revision to the mailing list (hope it
>>> won't waste the community resource), so that you could have a chance
>>> to review it and see whether that version is architecturally closer to
>>> what the community is looking for, while also addressing your issue.
>>> If you also feel that my next revision meets your needs, perhaps you
>>> could append your additional implementations on top of it.
>>>
>>
>> It seems we all composed the RISC-V iommu HPM support by referencing
>> drivers/perf/arm_smmuv3_pmu.
>>
>> Robin's comments should all be addressed IMHO.
>>
>>> Of course, if the community would prefer to go your version, I’m
>>> perfectly fine with that as well.
>>
>> OK. If we send a next version, we will add your SOB and please help to
>> review and test.
> 
> Zong Li's SOB should only be on the patches he authored. Don't put
> anybody's SOB on patches they haven't been involved in. See
> Documentation/process/submitting-patches.rst
> """
> The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery path.
> """
> 
 > Since Zong Li's patches were already on the list then your 
serieswould> at least discuss them in the cover letter, explaining why 
you've opted
> not to adopt them. But, most likely some of the patches can be adopted,
> so those should be extracted from Zong Li's work (with authorship
> preserved) and based upon in order to respect that prior work.
> 

You can see we have contacted each other in community, and decided to
cooperate in this way to honor his contribution. But final decision is
left for the community to decide:

 From Zong Li:
 >> Of course, if the community would prefer to go your version, I’m
 >> perfectly fine with that as well.

We respect all contributions, We'll add the link in cover letter to the
follow-up revisions, let me know if anything else should be done to the
new revisions.

--------------------------------------------------------------------

And let me describe in details to compare the functionalities and
addressed comments between what is provided by Joey and by Zong:

https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/

There is no missing functionalities between the two approaches, I also
checked the original Robin's comments, let me describe them in details:

1. The following comments require a split CYCLES implementation:

comment 1:
 >> Why not use an extra config bit to encode cycles events completely
 >> independently of the regular eventID space? Or even just use 0 since
 >> by definition that cannot overlap a valid eventID?

comment 2:
 >> It's also horribly confusing to use GENMASK for something which is
 >> not actually a mask at all.

comment 3:
 >> Hmm, from experience I would expect these variables to be
 >> number-of-counters related, but I guess there must be some special
 >> cleverness going on since that number-of-counters looking
 >> RISCV_IOMMU_HPM_COUNTER_NUM definition is conspicuously not used,
 >> so it must be significant that these are instead related to the
 >> number of...
 >>
 >> [ goes off to search code... ]
 >>
 >> ...event selectors? But with a magic +1 for reasons so obvious they
 >> clearly don't need explaining.

comment 4:
 >> One of those conditions is literally impossible, the other should
 >> already be avoided by construction.

comment 5:
 >> I don't think you need this - as best I can tell, you never
 >> initialise a counter without also (re)enabling the interrupt (which
 >> is logical), so since "value" for the cycle counter should always
 >> implicitly have OF=0 anyway, it should work to just write it like the
 >> other counters.

comment 6:
 >> Is RISCV_IOMMU_IOHPMCTR_COUNTER honestly useful? Or is it actively
 >> hurting readability by obfuscating that we are in fact just using the
 >> full 64-bit value in all those places?

comment 7:
 >> And that's a very creative way to spell "if (idx == 0)".

comment 8:
 >> (and as above, I think you can make this a no-op for the cycle
 >> counter)

These comments require a software architecture change to handle CYCLES
in a neat way. CYCLES is split and handled in the clean way in
iommu-hpm.

2. The following comments require an uncore non-sampling mechanism:

comment 1:
 >> You also need a "cpumask" attribute to tell userspace this is a
 >> system/uncore PMU.

comment 2:
 >> None of this is relevant or necessary. This is not a CPU PMU, so it
 >> can't support sampling because it doesn't have a meaningful context
 >> to sample.

comment 3:
 >> You first need to validate that the event is for this PMU at all,
 >> and return -ENOENT if not.

comment 4:
 >> As above, you can't support sampling events anyway, so you should
 >> reject them with -EINVAL.
 >>
 >> You also need to validate event groups to ensure they don't contain
 >> more events than could ever be scheduled at once.

comment 5:
 >> This will never do anything, since even if we could ever get here,
 >> it would not be at a time when there are any active events.
 >> Unregistering an in-use PMU does not end well (hence why standalone
 >> PMU drivers need to use suppress_bind_attrs)...

Here, Joey does check PMU type, does not include sampling event stuffs,
and cpuhp is handled in a fine grained locking way. And since locking is
handled correctly, it's safe to keep iommu-hpm as tristate.
The new approach requires more system software architecture techniques.

3. The following comments require a IRQ handling improvement:

comment 1:
 >> TBH I'd be inclined to just leave out all the dead cleanup code if
 >> the  PMU driver is tied to the IOMMU driver and can never
 >> realistically be removed.

comment 2:
 >> Surely this should only touch the counter(s) that overflowed and
 >> have been handled? It might be cleaner to keep that within the IRQ
 >> handler itself.

comment 3:
 >> This needs to start all active counters together, not one-by-one.

comment 4:
 >> This does nothing, since set_event has just implicitly written
 >> OF=0.
 >>
 >> ...unless, that is, the user was mischievous and also set bit 63
 >> in event->attr.config, since you never sanitised the input ;)

comment 5:
 >> What do these regs represent? If you look at the perf_event_open
 >> ABI, you'll see that events can target various combinations of CPU
 >> and/or pid, but there is no encoding for "whichever CPU takes the
 >> IOMMU PMU interrupt". Thus whatever you get here is more than likely
 >> not what the user asked for, and this is why non-CPU PMUs cannot
 >> reasonably support sampling ;)

comment 6:
 >> You still need to handle counter rollover for all events, otherwise
 >> they can start losing counts and rapidly turn to nonsense. Admittedly
 >> it's largely theoretical with full 64-bit counters, but still...

comment 7:
 >> Hmm, shared interrupts are tricky for PMUs, since perf requires any
 >> IRQ handler touching a PMU is running on pmu->cpu, so you have to be
 >> very careful about maintaining affinity and not letting anyone else
 >> change it behind your back.
 >>
 >> The other thing is that if it really is shared, at this point you
 >> could now be in riscv_iommu_pmu_handle_irq() dereferencing NULL.

comment 8:
 >> In general it's not a great idea to register an IRQ handler before
 >> the data passed to that handler is initialised. What is pointed to by
 >> (&iommu->pmu)->reg + RISCV_IOMMU_REG_IOCOUNTOVF if the IRQ fires
 >> right now (and/or if CONFIG_DEBUG_SHIRQ ever gets fixed)? ;)
 >>
 >> (OK, it's not *literally* NULL, but hey...)

Here OVF interrupt is handled as a standalone threaded per-cpu shared
IRQ in iommu-hpm.c and iocountinh register is not used as OVF interrupt
is always enabled and overflows is stored to software counters. The new
approach passed testings.

4. Other programming style fixes, they are all not in this patch.

comment 1:
 >> sysfs_emit()

No such problem here.

comment 2:
 >> Might be worth leaving a comment just in case anyone does try to
 >> enable this for 32-bit that the io-64-nonatomic readq() isn't enough
 >> to work properly here.

Not addressed in v3 and v4. And probably not necessary.

comment 3:
 >> That's a wonderfully expensive way to spell
 >> "pmu->events[idx]->hw.config"...

No such problem here, get_event() is used.

comment 4:
 >> Initially this looks weird - why bother storing constants in memory
 >> if they're constant? - but I see the spec implies they are not
 >> necessarily fixed, and we can only actually assume at least one
 >> counter at least 32 bits wide, so I guess this is really more of
 >> a placeholder? Is there a well-defined way we're supposed to be able
 >> to discover these, like some more ID register fields somewhere, or
 >> writing all 1s to various registers to see what sticks, or is it
 >> liable to be a mess of just having to know what each implementation
 >> has by matching DT compatibles and/or PCI IDs?

Here WARL registers are handled in RISC-V programming style.

comment 5:
 >> The new thing is that you can now set pmu.parent to the IOMMU device
 >> so their relationship is clear in sysfs, rather than having to play
 >> tricks with the PMU name.

Not addressed here but addressed in v4.

IMO, the Joey's approach addressed issue 1, 2 and 3, which does require
more software architecture changes. Her contribution and authorship
might also be honored.

--------------------------------------------------------------------

Am I missing something in the above list? Robin might help to confirm if
the new approach has addressed all his comments.

Thanks and best regards,
Lv

> Thanks,
> drew
> 

