Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872F3BFAEE
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891394; cv=none; b=qzH6Ndf1gz1EoMEVXA4nlL13c7+/c5ZlPBxAlfVBLuBYf/uRVqy8UjQCxL6cz7RGpEV8BDbFlYBP9Q9CFSIEqMMogOeLsxUTwBSPLjqVeKlnzN5UeUI/DTW+0DhFAYsz1iq3lrQRYmrC0FaBT6CpV3N4PQ4Jh1fHo6cs2skBtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891394; c=relaxed/simple;
	bh=PTuL6SZbklp1Gz60Jqay5+TjAIAerHb7yK/or20TelU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWoyvt8Jbu0yXaiGMLUpOiOKV6MteBIZ92l3Jcg6qfNnv+20iP3q52qoKUHyQZkZna5GdiztSDesEsk4FscEybg6867+8j6Fr9+cdQ/OSMhnxVixzilU6LWdPRA1bq+xdkKVTehW4crn+ZtPs4a1ywd1I8Q4RUrG1qiUzFPY8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqsJf0VYNzKHLyd
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:36:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6242C4056D
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:36:27 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgB3mYZ7w0RqACLSAQ--.34240S2;
	Wed, 01 Jul 2026 15:36:27 +0800 (CST)
Message-ID: <9bd14d31-8792-4b20-a82f-454ea22ab815@huaweicloud.com>
Date: Wed, 1 Jul 2026 15:36:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/21] perf annotate-arm64: Implement
 extract_op_location() callback
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-10-wutengda@huaweicloud.com>
 <20260701041002.EBBC31F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701041002.EBBC31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3mYZ7w0RqACLSAQ--.34240S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDCw4ftFyUXrWUArWDArb_yoW5Xw1fpr
	4j93y3Kry7tr45trnxXws7Gw1akwn3GF1agrWay3W3CFnIvFnagFs2kFn0gayrJrnxC3yj
	vr4jqrWUXwn8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Post-index memory references with register offsets are incorrectly classified as SIGNED_OFFSET.
> --
> 
> commit 1b03950d2edd24d57bf3a7ad6271aea1980c92e3
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Implement extract_op_location() callback
> 
> Implement the extract_op_location() callback for the arm64 architecture
> to handle its specific assembly syntax and addressing modes, enabling data
> type profiling for this architecture.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 451500def8c12..77b6f4841c849 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> +static int extract_op_location_arm64(const struct arch *arch,
>> +				     struct disasm_line *dl __maybe_unused,
>> +				     const char *op_str, int op_idx __maybe_unused,
>> +				     struct annotated_op_loc *op_loc)
>> +{
>> +	const char *s = op_str;
>> +	char *p = NULL;
>> +
>> +	if (op_str == NULL)
>> +		return 0;
> [ ... ]
>> +	/*
>> +	 * Handle memory references (e.g., [x0, #8]), identify
>> +	 * arm64 specific addressing modes
>> +	 */
>> +	if (*s == arch->objdump.memory_ref_char) {
>> +		op_loc->mem_ref = true;
>> +
>> +		p = strchr(s, ']');
>> +		if (p == NULL)
>> +			return -1;
>> +
>> +		/* Pre-index: [base, #imm]! */
>> +		if (p[1] == '!')
>> +			op_loc->addr_mode = PERF_ADDR_MODE_PRE_INDEX;
>> +		/* Post-index: [base], #imm */
>> +		else if (p[1] == ',' && strchr(p + 1, arch->objdump.imm_char))
>> +			op_loc->addr_mode = PERF_ADDR_MODE_POST_INDEX;
> 
> [Severity: Medium]
> Does this incorrectly restrict post-index addressing classification to only
> immediate offsets?
> 
> In ARM64, a comma immediately following the closing bracket (p[1] == ',') is
> sufficient to identify a post-index addressing mode, regardless of whether
> the offset is an immediate or a register (for example, Advanced SIMD
> instructions like ld1 {v0.16b}, [x2], x5).
> 
> If the condition fails for register offsets, it appears it will incorrectly
> fall through to PERF_ADDR_MODE_SIGNED_OFFSET. Could this cause the base
> register write-back to be silently ignored in adjust_reg_index_state(),
> leading to stale and corrupted type state tracking for the base register?
> 

I'd prefer to keep it as-is. SIMD instructions are not supported yet,
and the current restriction is safer. We can revisit if needed.

>> +		/* Signed offset: [base{, #imm}] */
>> +		else
>> +			op_loc->addr_mode = PERF_ADDR_MODE_SIGNED_OFFSET;
>> +
>> +		s++;
>> +	}
> 

