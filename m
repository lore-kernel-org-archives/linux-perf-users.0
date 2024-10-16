Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF102139A4;
	Wed, 16 Oct 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098764; cv=none; b=lkeEayji+cw3NyK3TdkakvA/1ZeLbiebD7VOq9Hceg74VHWvQ0b9eKp8VjOHFW8+GMz6KpD5ZxSt5MJcMQhoBvHSTJGqCVi5LO0r0fRnBBQ4WtX0+9PHHb6DRKWxWRJc3p7s2vDxl++B81ltT15WsqHrlzjb9pjyGtr223d0jcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098764; c=relaxed/simple;
	bh=+aXZrt6/RTi+SPWcF89FLkozplJ0sSJZth1HAEjojNE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rutAa6pVPiH4aO05uUT90725W8wR69zHjvVxlbwgDc35gJbq3vmBld0Ab50w41ai7UqZl6tlf+7X1R3BIpgshe0AccxM9EVujHKNQVGrJUaP4VAxEThGvmWiUb389Q/A65GP39Mi9sdZGC2Y//9LY7ckBC/YD0xv4XhiVTo2kAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8gpyoy9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8gpyoy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54C2C4CECF;
	Wed, 16 Oct 2024 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729098764;
	bh=+aXZrt6/RTi+SPWcF89FLkozplJ0sSJZth1HAEjojNE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=X8gpyoy9fr8LUnIRMSj0XOYsrHwRSu3cXR8vEY5pslXbvPTiqcTBvR6TxF3zZK9Fj
	 jRlQfFurLj+u4HtoKtcZ9GXso0em4jH/OmY/ti9jq8aKk9JNeGjZ4+hrBFUhTYuhy8
	 w28wQM3P21XVCIaaOUwCMJXSxllaAmM0VAqMIRJLbg8F74rX3Hq8oZySQcol1f2HUB
	 y3hK5/EaysXqjtV4jiTS85Fws1D82LkMsvqwwsbbd3GLpcoa58rPDbOSJTf2oJ05o7
	 /YwWLySvgi5qRLVfbqo3d9wh1ymSY8T9IOT5LDvCI1trLU5jvf7IxtuMxwA4zKmLOV
	 9FTmGVM52AbfA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Besar Wicaksono <bwicaksono@nvidia.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241003185322.192357-1-leo.yan@arm.com>
References: <20241003185322.192357-1-leo.yan@arm.com>
Subject: Re: [PATCH v3 0/7] perf arm-spe: Refactor data source encoding
Message-Id: <172909876374.288721.8485422607016756276.b4-ty@kernel.org>
Date: Wed, 16 Oct 2024 10:12:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 03 Oct 2024 19:53:15 +0100, Leo Yan wrote:

> As more Arm CPU variants (not only Neoverse CPUs) support data source
> encoding, they share the same format for the data source packet.
> 
> To extend supporting these CPU variants for Arm SPE data source, this
> series refactors the code. It converts the Neoverse specific naming to
> the common naming, and then based on the MIDR stored in the metadata to
> decide if the CPU follows up the common encoding format.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

