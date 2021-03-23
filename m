Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5DBC433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Mar 2021 18:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0726E619C6
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Mar 2021 18:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCWSGx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230461AbhCWSGf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Mar 2021 14:06:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDCF46192B;
        Tue, 23 Mar 2021 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616522794;
        bh=HlggJbtjjnl4gQvUpEErh5CAiwc0vAFXcF44xeAs6Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejMFqIsWGOyIOpCnuVC2LW3X6uvGY+6XjlVlM9WG4E9aPOSPmC/11IYmAoyoomB+x
         yGyWy+hfj44TDt/DT88eNROYgWywl+k9I2KfxrDbnWG7IIrwdV+0XEJOwUEUc8xSdP
         +js5qr8vlCDTE7xUYHuXzB1k5yfRsHFqhAelm2J0O8wFX3Fv+xZWBeSt69d6Dfxwgg
         ItRSbT9OjklihFREnuObjQwTNJu1h3J6lgSxOzRW+j0fntLMUBzBJTuMU+rQLNnQy8
         kMHh0p33TNPI5DRK3H88flJ+9h+rmZMmfDv5myaBpOUKehjpI7D5accqVOfErjTCxY
         ZWNNCqwwNZEew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C308940647; Tue, 23 Mar 2021 15:06:32 -0300 (-03)
Date:   Tue, 23 Mar 2021 15:06:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix perf test 42
Message-ID: <YFouKGT7oS1T/oMS@kernel.org>
References: <20210322125339.1384351-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322125339.1384351-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Mar 22, 2021 at 01:53:39PM +0100, Thomas Richter escreveu:
> For some time now the perf test 42: BPF filter returns an error
> on bpf relocation subtest, at least on x86 and s390. This is caused by
> 
> commit d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections")
> 
> which introduces support for global variables in eBPF programs. At least
> for global variables defined static.
> 
> Perf test 42 checks that the eBPF relocation fails when the eBPF program
> contains a global variable. It returns OK when the eBPF program
> could not be loaded and FAILED otherwise.
> 
> With above commit the test logic for the eBPF relocation need to change:
> 1. The function prepare_bpf() now always succeeds, the eBPF program
>    compiled without errors and returns a valid object pointer instead of
>    NULL.
> 2. There is no kprobe named sys_write, it now named ksys_write.
> 3. The function do_test() now returns TEST_FAIL because function
>    parse_events_load_bpf_obj() can not execute the eBPF program. The
>    eBPF verifier complains on an invalid map pointer:
>       libbpf: load bpf program failed: Permission denied
>       libbpf: -- BEGIN DUMP LOG ---
>       libbpf:
>       0: (b7) r1 = 0
>       1: (63) *(u32 *)(r10 -4) = r1
>       last_idx 1 first_idx 0
>       regs=2 stack=0 before 0: (b7) r1 = 0
>       2: (63) *(u32 *)(r10 -8) = r1
>       3: (bf) r2 = r10
>       4: (07) r2 += -4
>       5: (bf) r3 = r10
>       6: (07) r3 += -8
>       7: (18) r1 = 0x380006ce000
>       9: (b7) r4 = 0
>       10: (85) call bpf_map_update_elem#2
>       R1 type=map_value expected=map_ptr
> 
> Fix this by added logic to handle the kernel verifier return code:
> 1. Add function myksys_write() to cope with successful compile.
> 2. Use kprobe ksys_write
> 3. Handle eBPF verifier error.
> 
> Output after:
>  42: BPF filter                          :
>  42.1: Basic BPF filtering               : Ok
>  42.2: BPF pinning                       : Ok
>  42.3: BPF prologue generation           : Ok
>  42.4: BPF relocation checker            : Failed
>  #
> 
> Output after:
>  # ./perf test -F 42
>  42: BPF filter                          :
>  42.1: Basic BPF filtering               : Ok
>  42.2: BPF pinning                       : Ok
>  42.3: BPF prologue generation           : Ok
>  42.4: BPF relocation checker            : Ok
>  #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/bpf-script-test-relocation.c |  4 ++--
>  tools/perf/tests/bpf.c                        | 11 +++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/bpf-script-test-relocation.c b/tools/perf/tests/bpf-script-test-relocation.c
> index 74006e4b2d24..f8f8176ad4d1 100644
> --- a/tools/perf/tests/bpf-script-test-relocation.c
> +++ b/tools/perf/tests/bpf-script-test-relocation.c
> @@ -34,8 +34,8 @@ struct bpf_map_def SEC("maps") my_table = {
>  
>  int this_is_a_global_val;
>  
> -SEC("func=sys_write")
> -int bpf_func__sys_write(void *ctx)
> +SEC("func=ksys_write")
> +int bpf_func__ksys_write(void *ctx)
>  {
>  	int key = 0;
>  	int value = 0;
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index f57e075b0ed2..d60ef9472d3d 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -59,6 +59,11 @@ static int llseek_loop(void)
>  
>  #endif
>  
> +static int myksys_write(void)
> +{
> +	return 0;
> +}
> +
>  static struct {
>  	enum test_llvm__testcase prog_id;
>  	const char *desc;
> @@ -105,6 +110,7 @@ static struct {
>  		.name		  = "[bpf_relocation_test]",
>  		.msg_compile_fail = "fix 'perf test LLVM' first",
>  		.msg_load_fail	  = "libbpf error when dealing with relocation",
> +		.target_func	  = &myksys_write,
>  	},
>  };
>  
> @@ -258,6 +264,11 @@ static int __test__bpf(int idx)
>  		ret = do_test(obj,
>  			      bpf_testcase_table[idx].target_func,
>  			      bpf_testcase_table[idx].expect_result);
> +		if (bpf_testcase_table[idx].prog_id == LLVM_TESTCASE_BPF_RELOCATION
> +		    && ret == TEST_FAIL) {
> +			ret = TEST_OK;
> +			goto out;
> +		}

At this point, if it doesn't matter if it fails or succeeds, just drop
this test case?

- Arnaldo

>  		if (ret != TEST_OK)
>  			goto out;
>  		if (bpf_testcase_table[idx].pin) {
> -- 
> 2.30.2
> 

-- 

- Arnaldo
