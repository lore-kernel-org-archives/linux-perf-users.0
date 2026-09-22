Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0C548578
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082671; cv=none; b=re0rf7l9qLahIG5+9zHfI6gsm3WgTvj5swCN1a83ufHIkxrizvHq76OPpyrIUyR5R9po6FBPGdVOgOc/GpWSf7JiZwEWI7bCp34RQdPK3ZmXOSi0H+ynVfsrvPX7nNL6pSU2CsGY25EEeGuCEChA5wzFsDd/LAvLVOzJnzWEJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082671; c=relaxed/simple;
	bh=W8zNYj6dw/AtbnlT4lLlzyYzsVQM0HPA9qCrfZzEi2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trmjwSubbaJJMwF0/I29HY1xmaFWxzszfuGIRcQ96zGBjzddUH/GtDAo1W3GS1VYId55hFGSIIW68N3l3EasCVeojjNRWX4G8e5ji/QVyrQn3AosmK0C37hLYGUUjLKApRex8n5sJuEOFCBcYnOZxw9rGdZBr2eppBSCeV9TS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NY7DyYpd; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NY7DyYpd"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so626953066b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790082668; x=1790687468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41cWkJ/5UQL6xSUxgMCACGWpjEl5WhxoWOYGlmYevvk=;
        b=NY7DyYpdHfLgqwQ93xBhkNL5yU550b7q2xDIqwjhneTx0LMLotMQ2nYv5s8FUoJIaI
         IexWqg3G8niIVzzFH1t9NS0ZVrWWbEApk1++QqV36Ck0ZzZI9KPpr8VkCLrYmUqhStvH
         U82jWAsT9SO6UUvhpisg+jK/rMnkFhCPSqImGBNBJo//HD411jzLEmYVcf0TckPdktGS
         54WP7+C+guelVBx4i5BX9j+H+mUNPOYPgdgsAbrl13Hau/2G57YthazSzwiqnDB08VED
         UqRpwvGVoqf8/OBlr4vcKxV4mjTVrxyYes13nff2QHSMc5BzKzf1HuQNp8s1L6LrHUXt
         gmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082668; x=1790687468;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=41cWkJ/5UQL6xSUxgMCACGWpjEl5WhxoWOYGlmYevvk=;
        b=T5I2I003A/al8Jy44t+bJyW4s4zzsRm73KxkpqAnsPZe1ZSc+ORwQRkoXK7j5k3vkG
         V2E4rfidef4G1o7uiTEQwAs85Y7O7qoXUrw4/M/H+8X2fLoMbdSLQtsVc/yDjdliof9a
         GV4N45wbmg5R+IQijv6/RMFMlJ2EL9vtcv6QlvrsVeb4Zv3+Iw8Ko51b4GOQHnfui7MC
         FBiEwqmCcDZhO9sahfTUkP/yc2SC+/sp01WlH/m2Xi5qe6aE/QxkEmNrBOgNoUBsYnbB
         9qdNViT6GK8oSsBdBYK3bMbZm7ZESup+HA4bTITwpa6oN2veg93iD28RIALraRT6K9SR
         ovsA==
X-Forwarded-Encrypted: i=1; AKwUvByKCwdG5YKl4jtWPPmnTK9YBFiHeBn2wJrXm5dNyHH8rAnEpXjtHwMjGIhlM2SVO4T5KGrbaFlAMtZB9hlTqtBn@vger.kernel.org
X-Gm-Message-State: AFuF++lULgTh84/tboDTmhhwuERkch3RvByzPPLtckresKtNknMPhiB/
	RjJlA3HDpVGXRya0JMirwwC3qniF/ue/38t1zFE564ZVHHrVRTSYUFnIlB3rz6w1JZh8qKMj/z/
	MAo/sx9c=
X-Gm-Gg: AYBFou0fId+iC3X/vKP00JD65Y4lB74vo2CqnNk940qOM5jgN1o9k2G2CddDXw0cmum
	OnizQgxW/lHP8dhchTkCy9mdspquRRtozx0g3oZ0kmy+EDYTWXR+nAHAyCHXuKxvB/VwJmRZQxI
	bCMIKf1G0azp2TH+PqXOqpk/im6guuaMA//8Etug46ft+PJ8Y4Bp1DOYLnlHhBGV0Dkf4jGzBOP
	b01SxPi5DZFp5qwZBtf4BW5eit40Et9VedNIteb/yELflP+JSlmMtA+Ljl9ACc5JwvfGiLEVCNA
	Rnbj+pq9zyAP0g/f+hbRdgEHhwlJZTJjs4YuLvfXPMabGEkTs8Y2XnptY3EXtyV6JGZpDC+zZEy
	3bkgcPUVnjO0QbCcVprES8S9bT1DVth9hqdfHXjuklRb+sURSNNfq2it4oFwAeWDPYmg/e+/vOT
	sHPgPE7/jclLLH56/0UjLqtwAYxosZF4fqGVGoM4bnr1L98RFB28xAhLgfa6C8x+VTMMV8ogFWE
	Lm5
X-Received: by 2002:a17:907:3cc4:b0:c26:19de:9ad1 with SMTP id a640c23a62f3a-c2a15e53c92mr1279822966b.41.1790082667855;
        Tue, 22 Sep 2026 06:11:07 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aa9b14925sm7213066b.19.2026.09.22.06.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:11:07 -0700 (PDT)
Message-ID: <8e3ed898-5134-40df-84b0-b7cdaa777731@linaro.org>
Date: Tue, 22 Sep 2026 14:11:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/49] perf python: Add Intel PT call_return and itrace
 capability
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, leo.yan@linux.dev,
 linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 tmricht@linux.ibm.com, acme@kernel.org, alice.mei.rogers@gmail.com,
 linux-perf-users@vger.kernel.org, namhyung@kernel.org
References: <cover.1789966896.git.irogers@google.com>
 <b1d417e1f28afa565fa01b4997e3c31140e4772d.1789966896.git.irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <b1d417e1f28afa565fa01b4997e3c31140e4772d.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/09/2026 06:06, Ian Rogers wrote:
> Add support for Intel PT call_return events and itrace options to the
> perf Python extension so standalone Python scripts can decode and
> inspect low-level instruction traces.
> 
> Specifically:
> - Add a call_return callback parameter and itrace option string to
>    perf.session, treating explicit None (Py_None) callbacks as omitted.
> - Expose the perf.call_return object with db_id, parent_id, insn_count,
>    cyc_count, comm, pid, tid, call_time, return_time, branch_count,
>    call_ref, return_ref, flags, and call_path (resolved as a
>    perf.callchain ordered from outermost caller to callee).
> - Export perf.CALL_RETURN_NO_CALL, perf.CALL_RETURN_NO_RETURN, and
>    perf.CALL_RETURN_NON_CALL flag constants.
> - Expose session.e_machine and session.is_64_bit properties, preferring
>    recorded thread ELF machines (perf_session__e_machine) over perf_env
>    so pipe-mode traces do not prematurely cache host bitness.
> - Support optional vmlinux, kallsyms, and symfs symbol configuration
>    parameters (and PERF_SYMBOL_VMLINUX, PERF_SYMBOL_KALLSYMS,
>    PERF_SYMBOL_SYMFS environment fallbacks) in perf.session, resetting
>      symbol_conf pointers and freeing vm_tm_corr_args, cpu_bitmap, and
>    ptime_range in
>    pyrf_session__delete().
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/python/perf.pyi |  35 +++
>   tools/perf/util/python.c   | 624 +++++++++++++++++++++++++++++++++++--
>   2 files changed, 632 insertions(+), 27 deletions(-)
> 
[...]
> @@ -4161,23 +4585,40 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
>   {
>   	struct pyrf_data *pdata;
>   	PyObject *sample = NULL, *stat = NULL, *context_switch = NULL;
> -	static char * const kwlist[] = { "data", "sample", "stat", "context_switch", NULL };
> +	PyObject *call_return = NULL;
> +	char *itrace_str = NULL;
> +	char *vmlinux_str = NULL, *kallsyms_str = NULL, *symfs_str = NULL;
> +	static char * const kwlist[] = { "data", "sample", "stat", "context_switch",

Hi Ian,

This needs to be "static char *kwlist[]" to support older Python versions:

   Changed in version 3.13: The keywords parameter has now type char
   *const* in C and const char *const* in C++, instead of char**

> +			      "call_return", "itrace", "vmlinux", "kallsyms",
> +			      "symfs", NULL };
>   	struct pyrf_session *psession;
>   	struct perf_session *session;
