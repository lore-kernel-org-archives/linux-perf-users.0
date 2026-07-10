Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85518CC13;
	Fri, 10 Jul 2026 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644079; cv=none; b=WmUVdOadrgmaadbzOIpdSv8Njs1WI+qbmM9wc7ywV2fel2BJ6XFLYr0HfrNiaaAl91zQonzj21zw07nxDp6WwaWB5ATJn9ah6sG0MCr4Lncp0SKf7pRvWsR9CLGxToKUo21wkt27pQPW15jgrkXFRPQEFAe/e0W+3B6G4KVhBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644079; c=relaxed/simple;
	bh=deLXuKSavgLYZI27T8Ba8B3U8pVg46u4hOLrJtg19IQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rvzdmoIMq2RF+CBMprqrznKhGmtdP5zVFyK9WW1guP+puRa06PFCIw9/QA80M+ZQNlW0y9KyJCwLOSt/U6zbZtT9ZoF2e2VweuXcqk/8mohAw6nIU3Dm5eMx2Tq0riC/KSUQ6TQw7hnKS5zb8pNh8331EFqrk05OYBJ55yj+T6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQ3rC78G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ3rC78G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED66D1F000E9;
	Fri, 10 Jul 2026 00:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644078;
	bh=tveVP1kxcK9hTDBWb3H+Tiiahq5uleK+ELLfi0GV6UE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FQ3rC78GH54WcQWvPBP+aJPUXQ0S8prRw4DlgrF4ElEQVUa5x58wYXgP7ePf5Q9zb
	 dx9wQiolKR8iwRPfdpKe1xVz+wZHjIQ0go15XTF+sCv6tGauRfg9Wi5xsd3b2TOdJa
	 2lkZCDmxLULsOCnqpwbPCt8y4R+0r1EQnSvlnYH0MiflDAGdzSJnbFeimzDKw4JHnu
	 MhVHLbsOfFe69Lqy6+Un6rSynsuwHtVw4xuitL9BGkZnzo73TIKpLQ+wPy+T2B8HEf
	 jvqByqffYMp3UsIQE1/u+3bvclUtqOxN8rmUzHgQLzozVQfqrxfu2Pfh3pJtZUgiF9
	 V4pJEdVNeXkNw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sandipan Das <sandipan.das@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
 Ananth Narayan <ananth.narayan@amd.com>
In-Reply-To: <20260707190401.1427329-1-sandipan.das@amd.com>
References: <20260707190401.1427329-1-sandipan.das@amd.com>
Subject: Re: [PATCH] perf vendor events amd: Reintroduce deprecated Zen 5
 core events
Message-Id: <178364407793.1457655.9012811225786351296.b4-ty@kernel.org>
Date: Thu, 09 Jul 2026 17:41:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Jul 2026 00:34:01 +0530, Sandipan Das wrote:
> Maintain backward compatibility by reintroducing the events that were
> previously removed by commit 047979af3bf6 ("perf vendor events amd:
> Update Zen 5 core events"). Also set the deprecated flag and update
> the descriptions to point users to the correct alternative.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


