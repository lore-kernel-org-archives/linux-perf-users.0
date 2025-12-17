Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69FF246797;
	Wed, 17 Dec 2025 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985844; cv=none; b=qJzXTRItdL+6PQ4oHGJWBO3UZnmRehcmWGrdgEE8gvATN3MKvN2asaXQ1/wFNESQI2z+UXSWnvYefud2lybXP0R5WexkbFh0Te5eHLZaeI4/6WCOLVXvYsFkJaQTl293jlNqwBWWSUKdt1iO1IV70kM2y5YWm0OoUweoHCnaKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985844; c=relaxed/simple;
	bh=w3IRXQ9q0isDKPTdkYNfMqMOHkMJ8dDLNjGQLGDXiXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUricb0/Nycy9l6PUwrNBegYpnUAa0AHRqEWgriVkFZ50yonhAWeDJo08sVUpcU6W+FSCaPMMpzEkmvhcMEMcAAToahg/KOZICTh2wU7d743m9xULMuwS8ipXvRf5EAZr2l7EGvSjycC40INfKN+1oYBqQUlD/XavXpUlyARHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozDMTGCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozDMTGCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A43AC4CEF5;
	Wed, 17 Dec 2025 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765985843;
	bh=w3IRXQ9q0isDKPTdkYNfMqMOHkMJ8dDLNjGQLGDXiXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozDMTGCM/qYIJozAMnK3l6IQAQkePoa6uqogAU+X/Mb6C7C+z56Tg1ob7L1GIdBSW
	 C2YzwoF0MSzz8kSW7BSMgPxWvYNztbsbyvo5kZAl8iRccMwrSZGyqti/aVr6vv8EQL
	 e2PgipwlnWwGXuIXwePViPZ3N6JQHvXD8R8FrFbn9m185q9VA9sE5suVrhVlqcnvhH
	 Cdd5k10Hem9aqVl6T7a1VjBqjjT+tnoezndmV4spJfXwX7bq0jqzL9BIFV2UXfmH0J
	 tw+Ayx37WQLxfnAM8cEzOEqKKPwgbzlc+ZhqFz68AxSmrA8g3/LrtLPCugO62DtJdN
	 A8qMeuctKxgFQ==
Date: Wed, 17 Dec 2025 07:37:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: Ian Rogers <irogers@google.com>, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	sandipan.das@amd.com, Cristian Prundeanu <cpru@amazon.com>
Subject: Re: [PATCH v4 00/11] perf sched: Introduce stats tool
Message-ID: <aULOMekyd9_IiJBt@google.com>
References: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
 <cc87d705-0409-4451-b95d-8a9af94f0c1c@amd.com>
 <CAP-5=fWSFgkWggNaYDRno=Lv+s980_9ckr3vKy+CX2TsCJH+vA@mail.gmail.com>
 <3b7c8c6f-e54e-4bec-9e12-ca672671ad87@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b7c8c6f-e54e-4bec-9e12-ca672671ad87@amd.com>

Hello,

On Tue, Dec 16, 2025 at 03:39:21PM +0530, Swapnil Sapkal wrote:
> Hi Ian,
> 
> On 10-12-2025 02:33, Ian Rogers wrote:
> > On Wed, Aug 27, 2025 at 9:43 PM Sapkal, Swapnil <swapnil.sapkal@amd.com> wrote:
> > > 
> > > Hello all,
> > > 
> > > Missed to add perf folks to the list. Adding them here. Sorry about that.
> > 
> > Hi Swapnil,
> > 
> > I was wondering if this patch series was active? The kernel test robot
> > mentioned an issue.
> 
> The series is active. I have fix for the kernel test robot issue. I will be
> posting the next version in a week. I did not see any more review comments
> on the series hopefully it will be the final version.

Sorry for the delay.  I'll try to review the series next week. ;-)

Thanks,
Namhyung

