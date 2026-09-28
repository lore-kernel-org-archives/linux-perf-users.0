Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889233B6FB;
	Mon, 28 Sep 2026 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790556900; cv=none; b=Hw9S3+Dbor55pGGP/jGUJ2GgqnagT2C+M4Oumi/Ia/t1p2ZTbuHKpzAphWPJRUJy2O2310KYFf0xprNa6ShDUx6IGsh29ZAOrpdn3MrcJfmSVuSuf4giy37fk0odgEKCUlNRidFj7zAIBhph5Gil4o+RHoETX/bHY63NhuqpwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790556900; c=relaxed/simple;
	bh=94q9IW61AIF+y+RIMJqITcbS5KT1KHCCdYJJazbRI1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2rFuCWuh5IrWM6aFhH8/UmaqhbimgpaS3rYLcdcFtrCgF+OdBmWtgUTG2ByBmwjQupHDyFh1mFtUu2A3Ke2+1l7rDBOb7+Na4owxHxEzj5saRyXDWOrrHZrxRKHUhUbjGnnkndVZRoQxzFHFaN//Ct1iZ/hP3YQGrxU9YKznOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4htN9f5x3yzKHMPq;
	Mon, 28 Sep 2026 08:54:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 166EC40877;
	Mon, 28 Sep 2026 08:54:48 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgA3sPrWurlqyimdBw--.21204S2;
	Mon, 28 Sep 2026 08:54:47 +0800 (CST)
Message-ID: <124497c6-806d-4b64-9d1a-bb5d35189fbb@huaweicloud.com>
Date: Mon, 28 Sep 2026 08:54:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf llvm: Fix memory leak of args->fileloc in
 symbol__disassemble_llvm()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Steinar H. Gunderson" <sesse@google.com>,
 Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
 xueshuai@linux.alibaba.com, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Ian Rogers <irogers@google.com>
References: <20260917125802.1198419-1-wutengda@huaweicloud.com>
 <CAP-5=fVOdeA-cf1NRJxQ_YFeYKu3F1PJ3ykXR5Gtx7r0MtsUtA@mail.gmail.com>
 <arZFMCzEiHbTL6IK@x2> <arZF_Mphl3Rim0Gw@x2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <arZF_Mphl3Rim0Gw@x2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3sPrWurlqyimdBw--.21204S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF17Aw45Gr47trWUtr18Krg_yoWkWrb_GF
	1I9r1DCw47Ga12ya1qkrW2vrZrGF1ktryrAw4IgFs7Z3s3AFWkCF1xXFyrCw1jqwsFgr9x
	GrySvF9FvryavjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/25 17:59, Arnaldo Carvalho de Melo wrote:
> On Fri, Sep 25, 2026 at 11:56:04AM +0200, Arnaldo Carvalho de Melo wrote:
>> On Mon, Sep 21, 2026 at 11:36:08AM -0700, Ian Rogers wrote:
>>> On Thu, Sep 17, 2026 at 5:58 AM Tengda Wu <wutengda@huaweicloud.com> wrote:
>>>> In symbol__disassemble_llvm(), after calling llvm_addr2line(), if the
>>>> subsequent disasm_line__new() fails, the code directly jumps to 'err'
>>>> without freeing args->fileloc, leading to a memory leak.
>>
>>>> Fix this by explicitly calling free(args->fileloc) before jumping to
>>>> the error handling path when disasm_line__new() fails.
>>
>>>> Fixes: 048856817888 ("perf annotate: LLVM-based disassembler")
>>>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>>
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>
>> I replaced the free() with a zfree(&), minor.
> 
> I understand why you didn't use zfree(), to make it consistent with the
> other free, will keep it and leave the zfree() for later.
> 
> Sorry about the noise,

No worries at all, thanks for applying the fix.

Best regards,
Tengda

> 
> - Arnaldo

