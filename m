Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA0212D0A;
	Wed, 16 Oct 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098764; cv=none; b=sSgyweSFkngXokwNnqF8H2B6XcOPQ/HA/NZNkDwmv9+QBDk8ocT+VplazcBdPCCG2/CX1jbnQCb9hJjg1lYc5rx/H4yNuv7l1LrWlsP4Eq2ZXTromjU/Le9R5Lsk0EKu2EXFmRawGOcOEsqgTIJ+2CGviFDrxeCrU/dE79LTm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098764; c=relaxed/simple;
	bh=PMGT7Qvoq5gBx8nWkUlzvq1J8DycrICRUXpa1QY+fSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qz4fZG4G64ig9qT0tjxBQMTYO6qx8u56HgrFnmdAxNlzXzWrrGnl1Xuyg2ytpMnj4xI/OSckWyRaiziYjwCu+t2UkVUwa1HOUHqO+oZD+vbcuyn2mmBkbs8D39lJCzjTmvtE5exHVVuRAMOfi/G63BOS2kLFK6QWhhwrKUk7UnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca5lWMGF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca5lWMGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FD7C4CED9;
	Wed, 16 Oct 2024 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729098763;
	bh=PMGT7Qvoq5gBx8nWkUlzvq1J8DycrICRUXpa1QY+fSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ca5lWMGFsus27ZmtP6zfzw0gRfj0dd46YNbUv9VeRaU+D+OZmNiNTVvX+uzWVstw5
	 ZklIo7rC3XBqsXQe74LTu8vhlt7j1JCpgXA/Et86AWAZEOnITQZasHSy1meHABs+So
	 UHoAyRNN3a4xCWrxVXQXZ3fg1a0m+v2UcjGqCMx2GaaJNbXDEqBFRRervSobbkgetu
	 CiV9iMw6QQoO2tJysKlNZCxmhPin5v/9JJcsANUkpv9xIGHJ7rv+yM6O6scN+Adkn/
	 d46SmcJ4KRqLmveQq4j2l0aOBfDkKrCSAlgRfIkSgjx+E16Go1ycdF0MBFJNR0QfI3
	 wVi3LUKHC5qng==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, Howard Chu <howardchu95@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, matt@readmodwrite.com, kan.liang@linux.intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241011055700.4142694-1-howardchu95@gmail.com>
References: <20241011055700.4142694-1-howardchu95@gmail.com>
Subject: Re: [PATCH] perf test: Delete unused Intel CQM test
Message-Id: <172909876316.288721.302392506374666174.b4-ty@kernel.org>
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

On Thu, 10 Oct 2024 22:57:00 -0700, Howard Chu wrote:

> As Ian Rogers <irogers@google.com> pointed out, intel-cqm.c is neither
> used nor built. It was deleted in the following commit:
> 
> commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to files with no license")
> 
> However, it resurfaced soon after in the following commit:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

