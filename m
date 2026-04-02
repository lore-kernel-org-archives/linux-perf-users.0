Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1438837D
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167051; cv=none; b=cmH2RJEDx6X4jc7Dog7Lxl+PW9bMXIbrobnGus9izlq1ZAKN88SBNWTOyUNLTwAYjJqB5fUWpZo+eE7+vRzCRLQZH8SOf7fgJ13C2iaMip8MJ93V0p5jNirSw49VA0okVgj8faDjyo1mNz8fZ/OtATsJcjglKb2Yxum8S1FgZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167051; c=relaxed/simple;
	bh=XWIji/XrEWpGHeOqv0Bfu1d+OlDzeGR1jKCwluxiRPc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sv6iKd/8Ort7gub4ENg7+ylSWlDcHrgmahy53bXsIjggwIG2fewzq5r4PI9UpzQbUqcWZuNCeRwnNGBoG4EHNoNh+S/maF9fDsC6/D0AEZkRhDCq7SyVsxLUnSLxIKiFo3TEtckfVKh/IT+us5Ih30K+IE/m3FEthrauZDkGqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2vpPmYc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2vpPmYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6758C19424;
	Thu,  2 Apr 2026 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775167051;
	bh=XWIji/XrEWpGHeOqv0Bfu1d+OlDzeGR1jKCwluxiRPc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=C2vpPmYchgTfShZg9ghQy3H6OkIWZepGBlQfz2KHNaqdttZxXCOMPfO8hgo+IwlBq
	 fR+IdqT2PtdUG3Ja8XtrbaH6M6i6TqecbLRcymvsBlB8EuHhyylkUW2LT2/6nHE7c4
	 kEqbhNCW7gmp2ZCMvN2X7K1Z6+iTctMnZW7i7uyewUKnOr/PtY3X7og+irBVMQ1cVm
	 yYTeJum0pujTIoVXsFRb/aQIJCmRXy1MibMTcRSSYO8ZLEMOpuFJtUDJ67HzlHETGL
	 K2Y5p8AKenq058uO/Fw3V27wALg3YmiWv2GNnT3hEYN2oxJ8PsBZNAILwil/5YZnw6
	 dpllEMnHJ3X0A==
From: Namhyung Kim <namhyung@kernel.org>
To: mpetlan@redhat.com, acme@kernel.org, irogers@google.com, 
 linux-perf-users@vger.kernel.org, Anubhav Shelat <ashelat@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 dapeng1.mi@linux.intel.com, james.clark@linaro.org
In-Reply-To: <20260401132442.505507-2-ashelat@redhat.com>
References: <20260401132442.505507-2-ashelat@redhat.com>
Subject: Re: [PATCH] perf dso: prevent null dsos from being added
Message-Id: <177516705076.1014987.14774241958928201342.b4-ty@kernel.org>
Date: Thu, 02 Apr 2026 14:57:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 01 Apr 2026 09:24:43 -0400, Anubhav Shelat wrote:
> When sorting the dso array we sometimes get a crash due to null
> comparisons in comparator functions. So prevent __dsos__add from
> adding null to the dso array to avoid out-of-memory related errors.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


