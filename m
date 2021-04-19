Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77868C433ED
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Apr 2021 07:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D186113C
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Apr 2021 07:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbhDSHkI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:40:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237745AbhDSHkI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Apr 2021 03:40:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8E70AEB3;
        Mon, 19 Apr 2021 07:39:37 +0000 (UTC)
Subject: Re: [PATCH] perf annotate: improve --stdio mode
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <a0d53f31-f633-5013-c386-a4452391b081@suse.cz>
 <YDVb4KS/ARbtfoAw@kernel.org> <fedc723d-1c8f-fcd7-accb-421707b3a09f@suse.cz>
 <YG4IZhfYiE+2tyw7@kernel.org> <YG4VTsqJ9V3/hbOG@kernel.org>
 <4816a983-9d3c-2813-e9eb-1901b524e241@suse.cz>
Message-ID: <bdccc648-41e4-2719-cfbb-a9f44ff3b489@suse.cz>
Date:   Mon, 19 Apr 2021 09:39:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <4816a983-9d3c-2813-e9eb-1901b524e241@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

@Arnaldo: May I please ping this?

Thanks,
Martin

On 4/8/21 12:08 PM, Martin Liška wrote:
> On 4/7/21 10:25 PM, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Apr 07, 2021 at 04:30:46PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Fri, Feb 26, 2021 at 10:24:00AM +0100, Martin Liška escreveu:
>>>> On 2/23/21 8:47 PM, Arnaldo Carvalho de Melo wrote:
>>>> Sure. But I think the current format provides quite broken visual layout:
>>>>
>>>>       0.00 :   405ef1: inc    %r15
>>>>       0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
>>>>    eff.c:1811    0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8>
>>>>           :            TA + tmpsd * (TB +
>>>>
>>>> vs.
>>>>
>>>>       0.00 :   405ef1: inc    %r15
>>>>       0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
>>>>       0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8> // eff.c:1811
>>>>            : 1810   TA + tmpsd * (TB +
>>>>
>>>> I bet also the current users of --stdio mode would benefit from it.
>>>> What do you think?
>>  
>>> Agreed, I tried applying but it bitrotted, it seems :-\
>>
>> I refreshed it, please check.
> 
> Thanks! I've just tested the patch on top of acme/perf/core and it works as was planned.
> I'm attaching 2 perf annotate snippets (perf annotate --stdio -l --stdio-color=always) before
> and after the revision:
> 
> https://splichal.eu/tmp/perf-before.html
> https://splichal.eu/tmp/perf-after.html
> 
> I hope it nicely describes that it's an improvement.
> 
> Cheers,
> Martin
> 
>>
>> - Arnaldo
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 18eee25b4976bea8..abe1499a91645375 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -1368,7 +1368,6 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
>>  {
>>  	struct disasm_line *dl = container_of(al, struct disasm_line, al);
>>  	static const char *prev_line;
>> -	static const char *prev_color;
>>  
>>  	if (al->offset != -1) {
>>  		double max_percent = 0.0;
>> @@ -1407,20 +1406,6 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
>>  
>>  		color = get_percent_color(max_percent);
>>  
>> -		/*
>> -		 * Also color the filename and line if needed, with
>> -		 * the same color than the percentage. Don't print it
>> -		 * twice for close colored addr with the same filename:line
>> -		 */
>> -		if (al->path) {
>> -			if (!prev_line || strcmp(prev_line, al->path)
>> -				       || color != prev_color) {
>> -				color_fprintf(stdout, color, " %s", al->path);
>> -				prev_line = al->path;
>> -				prev_color = color;
>> -			}
>> -		}
>> -
>>  		for (i = 0; i < nr_percent; i++) {
>>  			struct annotation_data *data = &al->data[i];
>>  			double percent;
>> @@ -1441,6 +1426,19 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
>>  		printf(" : ");
>>  
>>  		disasm_line__print(dl, start, addr_fmt_width);
>> +
>> +		/*
>> +		 * Also color the filename and line if needed, with
>> +		 * the same color than the percentage. Don't print it
>> +		 * twice for close colored addr with the same filename:line
>> +		 */
>> +		if (al->path) {
>> +			if (!prev_line || strcmp(prev_line, al->path)) {
>> +				color_fprintf(stdout, color, " // %s", al->path);
>> +				prev_line = al->path;
>> +			}
>> +		}
>> +
>>  		printf("\n");
>>  	} else if (max_lines && printed >= max_lines)
>>  		return 1;
>> @@ -1456,7 +1454,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
>>  		if (!*al->line)
>>  			printf(" %*s:\n", width, " ");
>>  		else
>> -			printf(" %*s:     %*s %s\n", width, " ", addr_fmt_width, " ", al->line);
>> +			printf(" %*s: %-*d %s\n", width, " ", addr_fmt_width, al->line_nr, al->line);
>>  	}
>>  
>>  	return 0;
>>
> 

