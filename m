Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF2338910;
	Tue, 30 Jun 2026 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862556; cv=none; b=uWC+pp/w2+WdDDmp/IeJJf4X57syNJFOTmjDcsOX8SaD9upMQFFEnif5tC9RME1VyjiQoMtXe8PI8ZmLiaHBYR0+M1eAKF952OrHOxzxcbEPIbtRPfMJNCclM+Lbt+b20wrA45lHa59z34ZjAdmsQH7c1upBPVp101VaSfypp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862556; c=relaxed/simple;
	bh=NouJGh9XAZHKzkCHBpfoYDRLxnAP5CYM1tWFSdQKAA4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tBJVgEdSFA6e8g23LjZS5adLBJnkOUcvI9ep3SR1auh3NQnyeGFrdxhnh+wsk/WPWRWrVJybnLW7VkyQqANPxORiC0GdryBpqQXRqTBHUUdiJHgrwyl1xwanGlaZxy1DW+hoH7KeL8vw3mRNP8Ue5iU6k7WaXsF14Kj4AIPSswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJwu58mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJwu58mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3751F00A3E;
	Tue, 30 Jun 2026 23:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862555;
	bh=MFc41oW3E5gWpFqi+soESlRPUg6TArO3xdhw95q3tX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jJwu58mrIksNG9xsAdkv90jce/v9ONWYtOdXi0uc0T5esBdgVRe5UEFCTW2RCb8gm
	 VZNwdWBOgSFzzPUtNmfLILWwiqqKaA5QIKTQn9kTkT05VYP8OciWQtYjblQn57cnWb
	 4nRl8T849jr1xWZUMhq7kHIUvHRL12vLv0erYJbWZfqg/LWWufM5ExCEzj6bLqf4Ec
	 13h4BpbWt0kju3xJWPhrhwpgKqR99tsc23yqfusQ34IS1I5mjAf8xG53dCouGjGsEi
	 FoftWomMOhC3NhKDmeLU9DFAsGLcqyVg57gvOZfqqNKY4OZ6+7+SxL7aBywaX/hzFo
	 sBP9cdXLzzydw==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 atrajeev@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260518125041.39286-1-gautam@linux.ibm.com>
References: <20260518125041.39286-1-gautam@linux.ibm.com>
Subject: Re: [PATCH v2] perf kvm stat: Add missing mappings for PPC kvm
 exit reasons
Message-Id: <178286255486.2863034.396333551089947298.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:54 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 18 May 2026 18:20:38 +0530, Gautam Menghani wrote:
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the exit trap vectors and their names. Add mappings for H_FAC_UNAVAIL
> and H_VIRT so that exit reasons are displayed as string instead of
> vector numbers when using perf kvm stat.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


