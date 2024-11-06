Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DF1DEFE7;
	Wed,  6 Nov 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912588; cv=none; b=bZRlOQpkAzzU+cJCHPNv3LKIMwF9r0tw3mM4BZNIYPr++oBYk4Wt7Bw8VRd4b6IZWeBglkObqC11mhW6IqfkY8B6eG3KrYwqaquwg04vOXmdR8dSfFFGss5rxm0b/bdRUrWGd9OjrA++usP1+yw+Xqo+Yb2hrNmtWz4uDdD9AIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912588; c=relaxed/simple;
	bh=XhZqGAWJv/WIGiFmF1mpAoEYH2Qm4iFewR/mp118pp0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I8AhOVKcRyt5UmFcwBzZgd0We0xsw8jrGrTCdZv58K3StiJkdK7sYWsZCNl9b3+MI52uRX4bZzakandQAeeUfj6FPZDRFIqlT5MRhn9jnUiMKkd48TKwtgzibSNWkbZhHUDXgOrXpTw0lj5YmaPvJZHUiN0Y8X0k8fUYONTYcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4vr4eVq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4vr4eVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FE9C4CEC6;
	Wed,  6 Nov 2024 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912587;
	bh=XhZqGAWJv/WIGiFmF1mpAoEYH2Qm4iFewR/mp118pp0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M4vr4eVqH/lMLwlMtum7kNMQW+XXc5JsTKvKXQjnJHWEXM+3rdP+ex0q9F7H6ptd0
	 CJ9G6lxB1peZ56mPTs0MlPKPXIdQc9GBll+9w2gis9r6EJXP5TwdncdIWBK1J/yuB4
	 SFZDFHyHBOz40Q72DcXrf7PPPXoaVQBLm9JUGptYNWOS9nz1wx5wSZUsYL4i1wmUbe
	 EJefSbyfnputGdKPa13yItr/MSJgz23Mj3yU4npiovFEpESTWG+9sh6NRrmzVJlOp1
	 zmsbFTaIt78rnAQpDnf//vhUxGmwZQTQruU48fPqVgnludpdg3zaekw0KMuYKQ84zA
	 VnpuUpb5GGG6w==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Benjamin Peterson <benjamin@engflow.com>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
 howardchu95@gmail.com, irogers@google.com, jolsa@kernel.org, 
 kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
 peterz@infradead.org
In-Reply-To: <20241103204816.7834-1-benjamin@engflow.com>
References: <ZyV0a6e_46R9pmQw@x1>
 <20241103204816.7834-1-benjamin@engflow.com>
Subject: Re: [PATCH v3] perf trace: avoid garbage when not printing a trace
 event's arguments
Message-Id: <173091258725.804318.6915912692367845597.b4-ty@kernel.org>
Date: Wed, 06 Nov 2024 09:03:07 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 03 Nov 2024 20:48:16 +0000, Benjamin Peterson wrote:

> trace__fprintf_tp_fields may not print any tracepoint arguments. E.g., if the
> argument values are all zero. Previously, this would result in a totally
> uninitialized buffer being passed to fprintf, which could lead to garbage on the
> console. Fix the problem by passing the number of initialized bytes fprintf.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

