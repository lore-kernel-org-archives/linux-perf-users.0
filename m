Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68090C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 01:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481FF60FBF
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 01:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhIMBzV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 21:55:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:32466 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236903AbhIMBzU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 12 Sep 2021 21:55:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="218360122"
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="218360122"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 18:54:04 -0700
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="542841373"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.2.86]) ([10.238.2.86])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 18:54:02 -0700
Subject: Re: [PATCH v2 1/2] perf annotate: Fix fused instr logic for assembly
 functions
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, kim.phillips@amd.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210911043854.8373-1-ravi.bangoria@amd.com>
 <YTz9nfyXOSXDdpSE@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <211bb79d-80ff-e9b6-1851-1aaed987301d@linux.intel.com>
Date:   Mon, 13 Sep 2021 09:54:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTz9nfyXOSXDdpSE@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo, Ravi

On 9/12/2021 3:03 AM, Arnaldo Carvalho de Melo wrote:
> Em Sat, Sep 11, 2021 at 10:08:53AM +0530, Ravi Bangoria escreveu:
>> Some x86 microarchitectures fuse a subset of cmp/test/ALU instructions
>> with branch instructions, and thus perf annotate highlight such valid
>> pairs as fused.
> 
> Jin, are you ok with this? Can I have your reviewed-by?
> 
> - Arnaldo
>   

Oh, my original patch could only handle the case like:

cmp xxx
je  aaa

But it didn't consider Ravi's case something like:

cmp xxx
cmp yyy
je  aaa
je  bbb

Thanks for Ravi fixing this issue! Backward searching is probably a better solution.

Frankly I can't reproduce Ravi's case, but for my test suite, Ravi's patch works as well.

Reviewed-by: Jin Yao <yao.jin@linux.intel.com>

Thanks
Jin Yao

>> When annotated with source, perf uses struct disasm_line to contain
>> either source or instruction line from objdump output. Usually, a C
>> statement generates multiple instructions which include such
>> cmp/test/ALU + branch instruction pairs. But in case of assembly
>> function, each individual assembly source line generate one
>> instruction. Perf annotate instruction fusion logic assumes previous
>> disasm_line as previous instruction line, which is wrong because,
>> for assembly function, previous disasm_line contains source line.
>> And thus perf fails to highlight valid fused instruction pairs for
>> assembly functions.
>>
>> Fix it by searching backward until we find an instruction line and
>> consider that disasm_line as fused with current branch instruction.
>>
>> Before:
>>           │    cmpq    %rcx, RIP+8(%rsp)
>>      0.00 │      cmp    %rcx,0x88(%rsp)
>>           │    je      .Lerror_bad_iret      <--- Source line
>>      0.14 │   ┌──je     b4                   <--- Instruction line
>>           │   │movl    %ecx, %eax
>>
>> After:
>>           │    cmpq    %rcx, RIP+8(%rsp)
>>      0.00 │   ┌──cmp    %rcx,0x88(%rsp)
>>           │   │je      .Lerror_bad_iret
>>      0.14 │   ├──je     b4
>>           │   │movl    %ecx, %eax
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>   tools/perf/ui/browser.c           | 33 ++++++++++++++++++++++---------
>>   tools/perf/ui/browser.h           |  2 +-
>>   tools/perf/ui/browsers/annotate.c | 24 +++++++++++++++-------
>>   3 files changed, 42 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
>> index 781afe42e90e..fa5bd5c20e96 100644
>> --- a/tools/perf/ui/browser.c
>> +++ b/tools/perf/ui/browser.c
>> @@ -757,25 +757,40 @@ void __ui_browser__line_arrow(struct ui_browser *browser, unsigned int column,
>>   }
>>   
>>   void ui_browser__mark_fused(struct ui_browser *browser, unsigned int column,
>> -			    unsigned int row, bool arrow_down)
>> +			    unsigned int row, int diff, bool arrow_down)
>>   {
>> -	unsigned int end_row;
>> +	int end_row;
>>   
>> -	if (row >= browser->top_idx)
>> -		end_row = row - browser->top_idx;
>> -	else
>> +	if (diff <= 0)
>>   		return;
>>   
>>   	SLsmg_set_char_set(1);
>>   
>>   	if (arrow_down) {
>> +		if (row + diff <= browser->top_idx)
>> +			return;
>> +
>> +		end_row = row + diff - browser->top_idx;
>>   		ui_browser__gotorc(browser, end_row, column - 1);
>> -		SLsmg_write_char(SLSMG_ULCORN_CHAR);
>> -		ui_browser__gotorc(browser, end_row, column);
>> -		SLsmg_draw_hline(2);
>> -		ui_browser__gotorc(browser, end_row + 1, column - 1);
>>   		SLsmg_write_char(SLSMG_LTEE_CHAR);
>> +
>> +		while (--end_row >= 0 && end_row > (int)(row - browser->top_idx)) {
>> +			ui_browser__gotorc(browser, end_row, column - 1);
>> +			SLsmg_draw_vline(1);
>> +		}
>> +
>> +		end_row = (int)(row - browser->top_idx);
>> +		if (end_row >= 0) {
>> +			ui_browser__gotorc(browser, end_row, column - 1);
>> +			SLsmg_write_char(SLSMG_ULCORN_CHAR);
>> +			ui_browser__gotorc(browser, end_row, column);
>> +			SLsmg_draw_hline(2);
>> +		}
>>   	} else {
>> +		if (row < browser->top_idx)
>> +			return;
>> +
>> +		end_row = row - browser->top_idx;
>>   		ui_browser__gotorc(browser, end_row, column - 1);
>>   		SLsmg_write_char(SLSMG_LTEE_CHAR);
>>   		ui_browser__gotorc(browser, end_row, column);
>> diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
>> index 3678eb88f119..510ce4554050 100644
>> --- a/tools/perf/ui/browser.h
>> +++ b/tools/perf/ui/browser.h
>> @@ -51,7 +51,7 @@ void ui_browser__write_graph(struct ui_browser *browser, int graph);
>>   void __ui_browser__line_arrow(struct ui_browser *browser, unsigned int column,
>>   			      u64 start, u64 end);
>>   void ui_browser__mark_fused(struct ui_browser *browser, unsigned int column,
>> -			    unsigned int row, bool arrow_down);
>> +			    unsigned int row, int diff, bool arrow_down);
>>   void __ui_browser__show_title(struct ui_browser *browser, const char *title);
>>   void ui_browser__show_title(struct ui_browser *browser, const char *title);
>>   int ui_browser__show(struct ui_browser *browser, const char *title,
>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>> index ef4da4295bf7..e81c2493efdf 100644
>> --- a/tools/perf/ui/browsers/annotate.c
>> +++ b/tools/perf/ui/browsers/annotate.c
>> @@ -125,13 +125,20 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
>>   		ab->selection = al;
>>   }
>>   
>> -static bool is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
>> +static int is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
>>   {
>>   	struct disasm_line *pos = list_prev_entry(cursor, al.node);
>>   	const char *name;
>> +	int diff = 1;
>> +
>> +	while (pos && pos->al.offset == -1) {
>> +		pos = list_prev_entry(pos, al.node);
>> +		if (!ab->opts->hide_src_code)
>> +			diff++;
>> +	}
>>   
>>   	if (!pos)
>> -		return false;
>> +		return 0;
>>   
>>   	if (ins__is_lock(&pos->ins))
>>   		name = pos->ops.locked.ins.name;
>> @@ -139,9 +146,11 @@ static bool is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
>>   		name = pos->ins.name;
>>   
>>   	if (!name || !cursor->ins.name)
>> -		return false;
>> +		return 0;
>>   
>> -	return ins__is_fused(ab->arch, name, cursor->ins.name);
>> +	if (ins__is_fused(ab->arch, name, cursor->ins.name))
>> +		return diff;
>> +	return 0;
>>   }
>>   
>>   static void annotate_browser__draw_current_jump(struct ui_browser *browser)
>> @@ -155,6 +164,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
>>   	struct annotation *notes = symbol__annotation(sym);
>>   	u8 pcnt_width = annotation__pcnt_width(notes);
>>   	int width;
>> +	int diff = 0;
>>   
>>   	/* PLT symbols contain external offsets */
>>   	if (strstr(sym->name, "@plt"))
>> @@ -205,11 +215,11 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
>>   				 pcnt_width + 2 + notes->widths.addr + width,
>>   				 from, to);
>>   
>> -	if (is_fused(ab, cursor)) {
>> +	diff = is_fused(ab, cursor);
>> +	if (diff > 0) {
>>   		ui_browser__mark_fused(browser,
>>   				       pcnt_width + 3 + notes->widths.addr + width,
>> -				       from - 1,
>> -				       to > from);
>> +				       from - diff, diff, to > from);
>>   	}
>>   }
>>   
>> -- 
>> 2.27.0
> 
