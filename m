Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74D558218
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874185; cv=none; b=gGlAm/PqQ0grD84JojO71C1I/eIFcGTkPqCPpCAF6faE+wGXki7x5P8+XP1goFYlQr1Zge2kZpyKOGtLUvy0r6qVcBBWUFcFoNuZtVg5EVVwG3kFdVcWwV4MnPsK0nZzu+xQEp/46pfTDJL7JU9G9mcPaYchLrBjttXDaAQA8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874185; c=relaxed/simple;
	bh=ZKizfNiShIzK5A236udzWfnPv3WyjL2vKtPU2wXsSm4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2gNc3eqa2p/ga9uersxm3unXK7TVgZKJAK+w50dLBViiCS5yOnfZjClCNnOK9EfJZnJqQWuBTjKDRT/FFav808nJMbeYK6GsbsiiIb/i9ai4gae6FpvsvH7hl9GVd4gyurCzorOTlNPP3NHZHY0VXunNXPVJOuZNazWs+C6VZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv9I7qoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv9I7qoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6291F00A3A;
	Tue,  8 Sep 2026 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788874174;
	bh=ZKizfNiShIzK5A236udzWfnPv3WyjL2vKtPU2wXsSm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iv9I7qoHFo7CRhiaB1KmZD+aN+/RYcnzvKTS/5sEJw3W6dHasrerCavIvz1Abul4O
	 4RiVPpOGcETXSUMh0u6SghiHvg7aD+W7hIk1BJ+M0HbRoOLVABCTL0EfNA2bpLDZBg
	 n+yKU6W7t2TZCwoVeTiRC+p+vSz1Vz1N858+8u/xsbfjTr3ihTzUvn4Kr/HJNWkSlf
	 oDPn7wEuynvje9AKScKObqvqBSUoTrKMy6tdRX5W1XRhfjEF6arn0g/65cmqpSSrP/
	 QLEWE9uMRKM2ptquULY7CJPKyz8SIcV4OPs9ignA3KeaZEWq6GY7DUVReHD+bIc0AU
	 1lOJVdIcqPTYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/26] perf annotate-data: Track imm_value for stack
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <be42fd481faf3c5b8cc31efa2f5ce22131b4f878.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <be42fd481faf3c5b8cc31efa2f5ce22131b4f878.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:29:25 +0000
Message-Id: <20260908132934.2B6291F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently, imm_value is tracked in registers but dropped when values
> are saved to or loaded from stack variables during type profiling.
> If a register of type TSR_KIND_CONST is stored to the stack, its value
> will be lost.
>=20
> Add an imm_value field to struct type_state_stack and update
> set_stack_state() and findnew_stack_state() to accept and preserve the
> immediate value when updating stack state.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D19

