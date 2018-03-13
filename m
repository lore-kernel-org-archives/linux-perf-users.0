From: Martin Vuille <jpmv27@aim.com>
Subject: Re: [PATCH] perf annotate: Don't prepend symfs path to
 build_id_filename
Date: Tue, 13 Mar 2018 11:24:17 -0400
Message-ID: <e036d7fc-7787-3005-93f5-19ebfa339882@aim.com>
References: <20180211191937.9703-1-jpmv27@aim.com>
 <20180309190715.GB25111@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309190715.GB25111@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 03/09/18 14:07, Arnaldo Carvalho de Melo wrote:
> Em Sun, Feb 11, 2018 at 02:19:37PM -0500, Martin Vuille escreveu:
>> build_id_filename already contains symfs path if applicable, so
>> don't prepend it a second time.
> Where is the analysis that shows that that is the case? I looked here at
> the implementation for dso__build_id_filename() and couldn't find where
> was it that the symfs would be appended, can you clarify?
>
> - Arnaldo
>   
Patch resubmitted with additional details in commit message:

https://patchwork.kernel.org/patch/10279077/

Regards,
MV
