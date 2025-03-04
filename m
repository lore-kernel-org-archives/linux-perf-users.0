Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE41FC107;
	Tue,  4 Mar 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083575; cv=none; b=HX6iLhOKeCy2t3dcN8RWTq+dsjUqcxjJugZ3JgA50T+lEZku1Qg6HPETz+Yw94Z1rzaPb0IKzDyzJRMhtvWoeETW15MvAEy5hMvljeQ6ZA8BBpOdNiogjBVnbQo0hv3CLi8e7+H20iM+KJJR/VilHHOI+52vlOSTdxaVkYoHbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083575; c=relaxed/simple;
	bh=0LjOy3ExptYlSDWc+R79hQzLs5Ver27PeTWoOSJuVcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7XvWxq+YS5wBLwuv75Qe8HvGo/OlfW96ARnpnbBd7WDKPp9SXlLqj7WG3UaYer3+df/xT2K8DihDtQGJps2ClSV/L3vHG5p272NIWei72wmXSS2Y2arFdqAtyR3oo2i/2bc/48b8Ga36nk3eLfP4Ipi9UY41yT5bDHTtjFDC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Cu+DxP4E; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Cu+DxP4E"
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 524AIqSq2089857
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 4 Mar 2025 02:18:52 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 524AIqSq2089857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741083534;
	bh=3zxn+WrUBS8g5foCUUkpMpybK/Hi5/TPDqiPyN+NjBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cu+DxP4EQneH3TSWDP624/zH+OMfC7h5DGNGi6a0668Ux0qW1Pvgj+klioKCGuD1p
	 uM4s+8Kj79AjXwRo8ofkq3lErebXXq+ecKLc+BcbTCd8B7Rs2Yrr0Ikh6ZYyaXBiLD
	 ZV9pCeqBRYFJ7vv9oTbAqqIsJ7y2MT+9gH+/ibxCk62k+vn6xojnPpWGgz2EKkaIId
	 rBjm7LkVHvKF+H61e8SC2WdfBaUFK+BjyY8J2OWC0fueLxF8u2/mdyJEL/ofDaQG6n
	 6QEskWE8SVb9sssE+UCmHO0CjqGixeWD7rxvK+VscVBxnogbD1I+c0nw3sMsAjD7vS
	 eD10gMEryXoCg==
Message-ID: <8e4e1723-321a-4e8e-bbac-e2e5d8b08bfc@zytor.com>
Date: Tue, 4 Mar 2025 02:18:51 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] x86/cpufeatures: Generate a feature mask header
 based on build config
To: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: "Aithal, Srikanth" <sraithal@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, will@kernel.org,
        peterz@infradead.org, yury.norov@gmail.com, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com, nik.borisov@suse.com
References: <20250228082338.73859-1-xin@zytor.com>
 <20250228082338.73859-4-xin@zytor.com>
 <7c3b4623-45ea-4340-ac47-334071c1d15f@amd.com>
 <D03DAFD2-5EC9-4D16-BA66-FDA4B51F45DD@zytor.com>
 <20250303132505.GEZ8WtsXqFpuMOpDjT@fat_crate.local>
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
In-Reply-To: <20250303132505.GEZ8WtsXqFpuMOpDjT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/2025 5:25 AM, Borislav Petkov wrote:
> On Mon, Mar 03, 2025 at 04:05:54AM -0800, H. Peter Anvin wrote:
>> "make headers" on an unconfigured tree should presumably only produce the uapi headers, not kernel-internal ones, one could surmise?
> 
> Well, that's kinda a question for you guys:
> 
> cfc7686900a87   (H. Peter Anvin (Intel) 2025-02-28 00:23:36 -0800       281)archheaders: $(out)/$(featuremasks_hdr)
> 1f57d5d85ba7f   (Ingo Molnar    2015-06-03 18:36:41 +0200       282)    $(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
> 
> and the headers target has
> 
> headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts
> 
> as its prereq.
> 
> Judging by
> 
> 59b2bd05f5f4 ("kbuild: add 'headers' target to build up uapi headers in usr/include")

It seems that 'archprepare' works, however I'm not sure if it's the best
choice.  Any suggestion?

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 60583987d320..2db535958b8d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -276,9 +276,9 @@ $(out)/$(featuremasks_hdr): $(featuremasks_awk) 
$(cpufeatures_hdr) $(KCONFIG_CON
	$(shell mkdir -p $(out))
	$(call if_changed,gen_featuremasks)

-targets += $(out)/$(featuremasks_hdr)
+archprepare: $(out)/$(featuremasks_hdr)

-archheaders: $(out)/$(featuremasks_hdr)
+archheaders:
	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all

  ###

> 
> it sure looks like "make headers" should be for uapi headers only.
> 
> Oh, and it should be documented in "make help" output btw.

Want me to add it btw?

Thanks!
     Xin


