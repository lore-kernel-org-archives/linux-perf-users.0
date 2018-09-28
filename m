From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v2] perf test: S390 does not support watchpoints in test
 22
Date: Fri, 28 Sep 2018 14:07:29 +0530
Message-ID: <b743ec89-9e54-e54d-86cc-f3312e06e23c@linux.ibm.com>
References: <20180928074317.42893-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928074317.42893-1-tmricht@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Thomas,

On 09/28/2018 01:13 PM, Thomas Richter wrote:
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 54ca7d87236f..e83c15a95c43 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -124,7 +124,7 @@ static struct test generic_tests[] = {
>  		.desc = "Watchpoint",
>  		.func = test__wp,
>  		.subtest = {
> -			.skip_if_fail	= false,
> +			.skip_if_fail	= true,

Can you instead use ".is_supported"?

Thanks,
Ravi
