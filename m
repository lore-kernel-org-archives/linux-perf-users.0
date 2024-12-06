Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD53D6B;
	Fri,  6 Dec 2024 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474583; cv=none; b=nWNcWxzMHMg5s1Y/I/KzGRN+bpMZNccJRmeR7A2bYK4A7rqB/E7jxiNCX1wrsM9js8jCabXg3suRaGDbLl1P704+GmRpAwr3qpEIeWXUxs5+vRIpxxvWpPTyP7pt/cTXhsGd1YwquTi6PbhqbxyakfgNCFd4nuIez1xb2y2INtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474583; c=relaxed/simple;
	bh=ZHiBABMI79xBgIHNuRdiuyf1i8pHCLdohz2X+w3J8a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLvWo48jqd706QqvjXrKyXthUTSw56o2h6uhpTX+FkuuxbiF/4j4fvkib+vCztxb9kX+h//gtZR/uY69xyDSWmV6Ap1UuoHdHFeQgyXkegC1nC6oEcdKhXoQHaZpkS6+5CE+3R0P1AW8PHRZpYJ36Ebp6VDcrBbpp9wdNK93Ryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzeYcAWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzeYcAWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0FDC4CED1;
	Fri,  6 Dec 2024 08:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733474583;
	bh=ZHiBABMI79xBgIHNuRdiuyf1i8pHCLdohz2X+w3J8a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzeYcAWjz4H5owrTAvnQL8rm93An6tknE/hAhw/VOeUfh75QdczE6CjobDSbVL350
	 k1H9WQAkCoMRs5vZJkG/PBZcx4ooPD2IlhORKtwTTlmXCNziRI6VQqw82P7NWT4SNU
	 Fb6IxTIUdvFIx7yTnm4dC3r8gnAr5Bn1zLkKDNtCopzAGhZkezqbguoYOEoEzADH3n
	 TrNl6eAGTCEEzlS7dzO8l/yb7MrMHMkl3NjWB89uS+Di85zl2qmGi2HrzqFSG8q3z0
	 PIvb307wg9tOXBDXYjE/isYeK3aCieFgE9oCYbF+NlCFEXpZxMAggsOfKFdlGs5jTU
	 fqLqGUkGnHp1A==
Date: Fri, 6 Dec 2024 09:42:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH v2 06/10] perf/amd/ibs: Add pmu specific minimum period
Message-ID: <Z1K5D7zbwjXhZE2P@gmail.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
 <20241206051713.991-7-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206051713.991-7-ravi.bangoria@amd.com>


* Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> 0x10 is the minimum sample period for IBS Fetch and 0x90 for IBS Op.
> Current IBS pmu driver uses 0x10 for both the pmus, which is incorrect.
> Fix it by adding pmu specific minimum period values in struct perf_ibs.
> 
> Also, bail out opening a 'sample period mode' event if the user requested
> sample period is less than pmu supported minimum value. For a 'freq mode'
> event, start calibrating sample period from pmu specific minimum period.

Could you please capitalize PMU consistently, like the rest of the code 
does, both in code comments and in changelogs?

It's "PMU" and "PMUs", not "pmu" and "pmus". The only lower case use is 
when we mention 'struct pmu' - and that should be quoted.

Thanks,

	Ingo
