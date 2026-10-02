Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75748A8D1
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940514; cv=none; b=F6H8lJI+3Bf8j3eufTYohhNEZTw02atyc+Ugxa7jIMh5l+Ojrtaxy7O06EkS7W+Ann8ofSS8jfny5Kg6KWNn2hiEsRXerLSTl8midrFMrf/q6mv3I9+u/7iDksMZfk+qg0qptWgFqnHFm2sQSv3rQU9+zXaFJ6lHoAeh759/Bts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940514; c=relaxed/simple;
	bh=M6FDDo/Q25BBYJhl26VxGYsitEt2Wkk1Z4qbr5Lr92E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l3KyycpuRHzQtBcaMdipPY4MDVlZYgnwdndGfXCvPADJU6KzISi5wLVHRUtIF0mWRl4mSiK5ivbUm0uvbgHdyeFpVQUcrusKZ6NINT3oNUT3ue/vmkDYcF8G+c83ODe3EoI51V1Y8Y26wauauHtM8vVYMbHTbkkHoOIO9OKCHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjCE6PJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjCE6PJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003361F000FF;
	Fri,  2 Oct 2026 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940513;
	bh=M6FDDo/Q25BBYJhl26VxGYsitEt2Wkk1Z4qbr5Lr92E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TjCE6PJODmqk8ML6VHeVIqD2iYmaMuebvGAJLWoIAciSCsD8xeEl1toRQ5OGR1KfU
	 O9oScegyAsH3IE3hdN+EmoA2CJjTdZpgL4+R13zgMVAZGgDLkuipnvumJdYtBStbC4
	 Vvz9DrSs3MQ47o2EwaJISGZzJ4snec2VXJkrsMDnTAPEIzahnvV7YLSmjkkXDJpZKU
	 kw4Z2Vel+wzgcaxjvwo/NlVNVDYYSkxmGKJsg/8FYOKQGGxx2EUGudGXhnuts9MBAr
	 UsuEw27/i2vmHwjb7IFxfkcYg6sEC+MCEgBKLqkY8B55hNp2z+UuqDpiP/Xr/KRlFm
	 FE2NFoS51oUIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] perf: cs-etm: Don't add global v0 HW_IDs to
 unformatted queues
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-1-1d8b6ef339c8@linaro.org>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <20261002-james-cs-hw_id-output-failure-v3-1-1d8b6ef339c8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:28:32 +0000
Message-Id: <20261002112833.003361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In the case of mixed formatted and unformatted trace with v0 HW_IDs, or
> no HW_IDs at all resulting in the cs_etm__map_trace_ids_metadata()
> fallback, formatted queues will write their HW_IDs to unformatted
> queues. This will result in an assert because of multiple decoders on an
> unformatted queue.
>=20
> Fix it by not inserting trace ID nodes on other unformatted queues. This
> isn't an issue for v0.1 HW_IDs because they aren't global so will only
> add to their own queue.
>=20
> Fixes: 19c3e4db38c5 ("perf: cs-etm: Create decoders based on the trace ID=
 mappings")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-james-cs-h=
w_id-output-failure-v3-0-1d8b6ef339c8@linaro.org?part=3D1

