Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962382;
	b=BDbjCu3KaCKGyLJ+eIT3/DtcXQloL5CV1xYL4eXRhW6cHeD0Xje03ACHZLhBcA78HDhZ
	 li2nS1Yk+mlGj6Nea5DuD01pF5dbuD6FVuzxwSwG0kwakYS62tad4ApMFW4nhZ8jkMUt3
	 kGK6CAZtENm3eMaRf+24u9j7oIq/UaGsKYP/uV/30aRdVYCT9nhEj99rt6ne1Ayw3+FSs
	 5wfXbi6q+wUPdpwZX33a+nLX5/j8+mY4vPUeWKhGwAXTfwXkcEiwt9y+4njf4sszH7cfn
	 HwRMq5VYlP7/K0b+B2sGTK0LhgbdYSXI1exiZM3F42EBqSb/O8BV03eYv6YCm/GyhrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=krNpsbiQG+hzRBKHXK674c/mVmHxgpPrHZyp9wwN0+M=;
	b=3jjCek6BRf56RiQ76ul1t6kPH5f91lucf1gXZoKxxLjtVwaxM0rHneA+1EkvrNNNGnWT
	 qkRr/PubV46LOdEXJKiKaWi97VmJ6NGOEy/o/aq1/GX+3Vt0SDDhXzcDZN9sKgk8W0f74
	 lbcIpiysmtLK3WcKuoLMxVLlNQu39n2GfZ3NLqrCSrHRUHJqIhXnybWJ3XkC+/HMnNRZ7
	 6F3DG8KE7E+rwf5eVSCr5sxXbcg8WS0S4rxzP1t1IIhmH+thivB1BZ882uBSr0Ex/ziMB
	 Hl6XxHBWDNQDLknihELsXOWeLlqjZnM41win2AY6SSmDf5t4Nh/LNRLs5X44x4lcisA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ML5ASPcn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1C606D807
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ML5ASPcn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5478D1F008A1;
	Fri,  6 Nov 2026 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793962382;
	bh=krNpsbiQG+hzRBKHXK674c/mVmHxgpPrHZyp9wwN0+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ML5ASPcnZYazdn3wobxJZ4jpivepnRIiciULvApOhaif1bQMU0lmiXvpZpEeKbT/Z
	 cHgqWh11CaW1fxc9TH9+uGS3DDirKf8ux0AG9bx6VYQK9cxvavhm/DOaPmhdPUcshP
	 TfLlIk4yr02nNNT+UDw9RFocPKyrZl4R3BZ/G3cl814lXaVwYk0E33XQACJtERTceS
	 BSKxFv6sA/6Xqx0i6pCiGudvJcuy+jHc3X8TEqyIt54+0jpp/26rvrqwHCv+3KPANe
	 777RAcd16PU0BUhygq6uaiq4W9KgFIfyBQ134xUzT6xMDV7pK7ijLdRBbwqSDLcqPy
	 RQvohhD6akSUw==
Message-ID: <sashiko-outbox-201238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf test probe_vfs_getname: Fix missing
 debuginfo detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106-james-perf-test-fixes-v2-3-9a912662f822@linaro.org>
References: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
 <20261106-james-perf-test-fixes-v2-3-9a912662f822@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:53:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> skip_if_no_debuginfo() looks for the errors that 'perf probe' prints when
> there is no debuginfo in the output of add_probe_vfs_getname(). But since
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected"), add_probe_vfs_getname() returns early without adding a
> probe if 'perf probe -L' doesn't find the line, which is also what
> happens when there is no debuginfo. The error from 'perf probe -L' is
> discarded, so the debuginfo errors are never found.
>=20
> This causes the debuginfo dependent subtests of the
> "perftool-testsuite_probe" test to fail instead of being skipped on
> kernels without debuginfo, because test_adding_kernel.sh calls
> skip_if_no_debuginfo() unconditionally. The other users only call it
> when add_probe_vfs_getname() returns 1, so they aren't affected.
>=20
> Fix it by doing a dry run of a probe that needs debuginfo instead. This
> [ ... ]
>   ...
>   189: perftool-testsuite_probe : FAILED!
>=20
> Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable li=
ne detected")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-james-perf=
-test-fixes-v2-0-9a912662f822@linaro.org?part=3D3

