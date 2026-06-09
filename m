Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F877384CCA
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987553; cv=none; b=GbCeFht+s/hLvYEGcp3Agp1UmqeUp9LKJUa+w8gIV/vagEqqtgbnei1Q+WmBrrp9s0cv9COut21txelQG+Vf+/EN5nb/4di6RkcurH4FosWfmTVBlrFRfivSlwuqp44MMxsentdcWLQ5TL1IQr39Akn+2KIrkZr8NYzhwef1YW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987553; c=relaxed/simple;
	bh=HQwmncRdiv6AtGpVYfikN3+5KsHmheFOnPmApR/150U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bSHX/Anc04IWfSpyFumJxgZMBi6U3k8KJrjWZjsGhMA1B2EWWQ4RFif0JHF5FjfIak+ScgBxXKX7EgAsyxsGELSd82nD3J93CP5mEEF4fjc4gwjxK9u1lLTQHt3VK90vG4Ns0i+zTQMP+Abf+4h0s4HctTexURpve+OfOGYxT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToW9xyco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToW9xyco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F6C1F00898;
	Tue,  9 Jun 2026 06:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780987552;
	bh=inK/46gKpdssexq5gCszlSU5AT8S2l6ZVa4cOSDn/rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToW9xycoxhJb8oBKGgIk+vj8E7szV9wBZVTeNZGJk5V2wSiUKzEpXrbxJ/Mkg2Y/p
	 C1sfeVqwzfqptyWfnLsNY4kbgc59Tr5J9KS+d/LqTrbhGiOFwkGe3zkERsa+r//mtt
	 0Dg5EivjPved2Bvkw3Rv6RtdW6y044KXwFmKk+HWigiOUmzRyFkBOva0MwJZU0oT4m
	 8wQpHyFoKIRracuwwlTOj1N68DbhrOaq/lKYFweSPmTi3hyhYiQWigKpItCmSrvPLD
	 bKzh67Wg2snr7UqwAGfe79C84vMAPzL9383FajdH6oPfSb8oVYy8E5h1723zPpC4CB
	 eZxI+9DazHv6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] selftests/livepatch: Add RISC-V syscall wrapper
 prefix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Han" <wanghan@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609063002.3943001-8-wanghan@linux.alibaba.com>
References: <20260609063002.3943001-8-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:45:51 +0000
Message-Id: <20260609064551.E2F6C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The module initialization function `livepatch_init()` leaks `klp_k=
obj` and its associated sysfs directory if `klp_enable_patch()` fails, lead=
ing to a kernel use-after-free.
--

commit 35d6758515b1de6295d7ae1a97c70e768cac9dfc
Author: Wang Han <wanghan@linux.alibaba.com>

selftests/livepatch: Add RISC-V syscall wrapper prefix

The syscall livepatch selftest resolves and patches a syscall wrapper
symbol. To use that test for RISC-V livepatch validation, add the
RISC-V FN_PREFIX definition for ARCH_HAS_SYSCALL_WRAPPER.

> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_sysc=
all.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> index dd802783ea849..275e4b10cf595 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> @@ -18,6 +18,8 @@
>  #define FN_PREFIX __s390x_
>  #elif defined(__aarch64__)
>  #define FN_PREFIX __arm64_
> +#elif defined(__riscv)
> +#define FN_PREFIX __riscv_
>  #else
>  /* powerpc does not select ARCH_HAS_SYSCALL_WRAPPER */
>  #define FN_PREFIX

[Severity: High]
This isn't a bug introduced by this patch, but does livepatch_init() leak
klp_kobj and its associated sysfs directory if klp_enable_patch() fails?

If klp_enable_patch() returns an error code, livepatch_init() returns this
error directly without calling kobject_put(klp_kobj):

tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c:livepatch=
_init() {
    ...
	klp_kobj =3D kobject_create_and_add("test_klp_syscall", kernel_kobj);
	if (!klp_kobj)
		return -ENOMEM;

	ret =3D sysfs_create_file(klp_kobj, &klp_attr.attr);
	if (ret) {
		kobject_put(klp_kobj);
		return ret;
	}
    ...
	return klp_enable_patch(&patch);
}

Because the initialization fails, the module loader frees the module memory,
but the sysfs file /sys/kernel/test_klp_syscall/npids remains registered.

A subsequent user-space access to this sysfs file could dereference a point=
er
to the now-freed module data (klp_attr) and execute a freed function pointer
(npids_show), resulting in a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.194d76e3a15b.=
v3.riscv-livepatch.wanghan@linux.alibaba.com?part=3D8
