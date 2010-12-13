From: "David S. Ahern" <daahern@cisco.com>
Subject: Re: [PATCH 1/2] perf tools: Add reference timestamp to perf header
Date: Mon, 13 Dec 2010 07:39:24 -0700
Message-ID: <4D06301C.2090309@cisco.com>
References: <1291773285-16254-1-git-send-email-daahern@cisco.com> <1291773285-16254-2-git-send-email-daahern@cisco.com> <20101212201613.GA1784@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:45682 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0LMOjY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 09:39:24 -0500
In-Reply-To: <20101212201613.GA1784@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/12/10 13:16, Frederic Weisbecker wrote:

>>  int perf_session__create_kernel_maps(struct perf_session *self)
>>  {
>>  	int ret = machine__create_kernel_maps(&self->host_machine);
>> @@ -167,6 +190,9 @@ struct perf_session *perf_session__new(const char *filename, int mode, bool forc
>>  		 */
>>  		if (perf_session__create_kernel_maps(self) < 0)
>>  			goto out_delete;
>> +
>> +		if (perf_session__create_ref_time(self) < 0)
>> +			goto out_delete;
> 
> So, it does record it anytime?

Simplest to always add it the header as it does no harm if not used. To
make it conditional means adding an input parameter to
perf_session__new() and then updating all the callers.

Is the preference to make it conditional?

David


> 
>>  	}
>>  
>>  	perf_session__update_sample_type(self);
> 
> 
> Other than that, looks good!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
