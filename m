Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FE45C18
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Mar 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445717; cv=none; b=MiQchd7XCUyTUOHArIMz4gcb0bKwNRjIiF679D0uFOGTuuSiojnidnZy9kkiMBVSqYSSKhMKxG1vLiwz6PydEcpW/Fg8BoF4ilCn9B6WsmL6ncwd8ZMzm5HnbZLVv47H+WDxpPuMcXPleLdMklwq69gzDm2cqH+BOB/uT1vjyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445717; c=relaxed/simple;
	bh=AuBPGlc2S5bTaKFMc3qlfOSSM4pupvF9qJ0mH3B8dgY=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eptH+2sWkoC1Q0iKo9mkLxvFDtW0o54u7IE4OzXGGhR4hyjgWRW9qk/CAgh2Gy7Bd2uC1iPDjQAn6nHDq4G9pY5YzS6NrudcJC8TekMTNX6j+l07vcs5YtXD72mqyculTWSkntnZqOrgnpP1NR5g5bwVjdQJP9/aavZsGRRlfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxOPDNlgJmA1IeAA--.6151S3;
	Tue, 26 Mar 2024 17:35:09 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx8OTIlgJmZL1oAA--.10454S3;
	Tue, 26 Mar 2024 17:35:04 +0800 (CST)
Subject: Re: [PATCH 3/3] tools/perf/arch/powerc: Add get_arch_regnum for
 powerpc
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
 namhyung@kernel.org
References: <20240309072513.9418-1-atrajeev@linux.vnet.ibm.com>
 <20240309072513.9418-4-atrajeev@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <4072f03b-a8a2-5611-901e-bc16e97c3fe6@loongson.cn>
Date: Tue, 26 Mar 2024 17:35:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240309072513.9418-4-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Bx8OTIlgJmZL1oAA--.10454S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JrW8Cr1UWF1ruFy7ArW7KFX_yoW3CFbE9a
	97Jr97JrWrXFnrKFy7GrWrZ34Fka13GFZxXF48Xa47Grn5ZFZI9F45Xrn3Cr10qr18Jrs2
	kr1ktrn5Ww129osvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcApnDU
	UUU

Hi Athira and Namhyung,

On 03/09/2024 03:25 PM, Athira Rajeev wrote:
> The function get_dwarf_regnum() returns a DWARF register number
> from a register name string. This calls arch specific function
> get_arch_regnum to return register number for corresponding arch.
> Add mappings for register name to register number in powerpc code:
> arch/powerpc/util/dwarf-regs.c
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/dwarf-regs.c | 29 +++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

I found commit 3eee606757ad ("perf dwarf-regs: Add get_dwarf_regnum()")
for x86, would you be able to share how to test these changes? What is
the difference with and without the patches?

Thanks,
Tiezhu

