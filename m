Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EF41F7FD;
	Mon, 14 Sep 2026 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378711; cv=none; b=SfAu0qlZ8JmpAMheWLtR7B+EdJUxOKXI+50OGQsrQrBrbkJZiS5A0xtH+HKKSuH3h6yv4qlyI7eAhUuYmUXZePDltwOgA+GerPCksprCU7THKyuwFzhGJW4ZNhVnx13i3z+YCz1oa9qW8ghV6tIrQot6II6ZE6vZd0eYu9R8vCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378711; c=relaxed/simple;
	bh=kS/fhl7f3dND0iPGjp2SusrWniYn7mPeLl9xjmSREwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dffzB45Lpq3MWu7MHnaxVCOi572ZOVIP6TgNzFFZPnoXc2jSKcWV49E/+/mTUzn9JfjGvjKk5qYP/Xp7NdNXx5AE69V94Oz1sIZzXyZIIy5EZMlbJSUX9Ai7uawml5rAwudBvSoXlXQeVPxS0khQdl/jOfPr6+UNCFDNU9iN1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNmkMgzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNmkMgzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361641F000FF;
	Mon, 14 Sep 2026 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378709;
	bh=kS/fhl7f3dND0iPGjp2SusrWniYn7mPeLl9xjmSREwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNmkMgzNq47bs7NsDj2vhFtP7YynPfA0FUnIkd4ytg3mikHf1jYZLvWDuM064Rou2
	 NvOVSgy6vR8wk9peR6pg4Jxd4YmRoGB0pkHwrlzBuBhE1qVQKw/83k1kyVMHN1wJ0p
	 ovcKiNqv1l3D7KvkhVJLNj/Ach5fFfbULPr2O+5vo0/+osyCLs+YVSF9m+LtJevDcH
	 8qGP5xxCQmcikuwmI9/FzdU2vJ9ubPIaXFjSGaiJG6BK/pPRlLm1DuhURIA308oCge
	 MyIo6Ye9bmN0SfP0Begh7xRSzL1s1KCKIWxnbjyp7WgoJyQgO4jOA4tki32TpzvYue
	 yg7THCoivpfjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/7] selftests/livepatch: Add RISC-V syscall wrapper
 prefix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260914092648.51254-8-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20260914092648.51254-8-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:38:28 +0000
Message-Id: <20260914093829.361641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> The syscall livepatch selftest resolves and patches a syscall wrapper
> symbol. To use that test for RISC-V livepatch validation, add the
> RISC-V FN_PREFIX definition for ARCH_HAS_SYSCALL_WRAPPER.
>=20
> Without this macro, the syscall livepatch selftest cannot resolve the
> RISC-V target symbol, and the syscall-related livepatch test fails on
> RISC-V.
>=20
> Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092648.5125=
4-1-xueshuai@linux.alibaba.com?part=3D7

