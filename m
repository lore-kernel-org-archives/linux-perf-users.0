Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53D6F08B;
	Tue, 18 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696065; cv=none; b=jYDMPi+7kDq/FDwRlU4PylDnua/gl0n3kY82C1/O1paf0Zl0UR9ywGgX/gbWBND2LE9oAWhMdbV13k2mR1/7OmEHkjJdQA5JY14q8gjC/FLTA/QbnElKneN/T1COTiPLGv12hwDbRjveIZIBrpsGu+ibvRYZ+GwaZXYKcVYlXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696065; c=relaxed/simple;
	bh=JvKUA0uAhWTBOu53AK8ZlfFwtpiLZgEgCTIKp6QqhqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1GenvcdOYAt6tKhdX3BZOXlIK8S8dCUZcdPJVX2msBjE2U91NDeCgRKlcXrpaTauCmMv95WIsypWC/BKN/QhMRemM7wFpaCpNbv4kkbHph0LtvYko0XHlbr4i4Nc80QZdNmJ32gpJJCSr+d3jKufmvIzywGaW7mG7naI86g4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Qm2zu9xR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qm2zu9xR"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45I7Xjax1896939
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Jun 2024 00:33:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45I7Xjax1896939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1718696027;
	bh=D7YpJt/0zUNu+VsyD3AzsDyFHnAKQaQWvyS73/NuEfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qm2zu9xRhmYJmV/eW2gBqcXhNDIjKpSDqaI1zrevwdivvXiFUNGp6cL9z9VNkdjDT
	 cJ1qNMy2HNQLGdVSe/ghCN/XWYsrBJqolnEldzPmFJtbHgZAQRJG4/na2yai2XKVEM
	 /iJnWikX6WazweObPWAlznQGwYx1BtMeVJrbndNfuKh4gDrHNXgwpeG12P0k/Cqs7n
	 FR7lYZT8QUEpk6APN7pdcNG5LEvEjXSzWIWidB2T9usYY40C0X+xtyJSSEI2jyzZdD
	 rbVCo5dJWBg17v0PvPpkz7BCxALjNgXCoS4fD7oseY0SqMyNyWa3haJ0umqOrjqKi8
	 4v3Hnu4T8v3DA==
Message-ID: <390e41a2-26c1-41da-86bd-6632b39f2706@zytor.com>
Date: Tue, 18 Jun 2024 00:33:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86/cpufeatures: Generate a feature mask header
 based on build config
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
References: <20240616085743.1100704-1-xin@zytor.com>
 <20240616085743.1100704-3-xin@zytor.com>
 <CAMzpN2jQrgaPR2R_=sBRmjGvbpX1ZSCrr9zJ+TM9N1ymg5_OiA@mail.gmail.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <CAMzpN2jQrgaPR2R_=sBRmjGvbpX1ZSCrr9zJ+TM9N1ymg5_OiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/17/2024 9:34 AM, Brian Gerst wrote:
> On Sun, Jun 16, 2024 at 4:58 AM Xin Li (Intel) <xin@zytor.com> wrote:
>>
>> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>>
>> Introduce an AWK script to auto-generate a header with required and
>> disabled feature masks based on <asm/cpufeatures.h> and current build
>> config. Thus for any CPU feature with a build config, e.g., X86_FRED,
>> simply add

>> +
>> +file == 2 && $1 ~ /^CONFIG_X86_[A-Z]*_FEATURE_/ {
>> +       on = ($2 == "y");
>> +       printf "/* %s = %s (%d) */\n", $1, $2, on;
> 
> This looks like extra debugging output that doesn't need to be in the
> final release.
> 
>> +       if (split($1, fs, "CONFIG_X86_|_FEATURE_") == 3) {
>> +               printf "/* %s %s = %d */\n", fs[2], fs[3], on;
> 
> Same.

Right, they are comments but better remove them.

>> +       printf "#define SSE_MASK\t\\\n";
>> +       printf "\t(REQUIRED_MASK0 & ((1<<(X86_FEATURE_XMM & 31)) | (1<<(X86_FEATURE_XMM2 & 31))))\n\n";
> 
> This could be moved to verify_cpu.S, since that is the only place it is used.

NP.

>> +       printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
>> +}
>> --
>> 2.45.1
>>
>>
> 
> You could also generate {REQUIRED|DISABLED}_MASK_BIT_SET() in this
> script, so that they are always in sync with NCAPINTS.

Yeah, just better to make this an add-on patch.

Thanks!
     Xin

