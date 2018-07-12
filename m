From: Stefan Raspl <raspl@linux.ibm.com>
Subject: Re: [PATCH] perf kvm: Fix subcommands on s390
Date: Thu, 12 Jul 2018 16:17:14 +0200
Message-ID: <de10696f-0fc3-4e34-d6dc-f9e669adc568@linux.ibm.com>
References: <20180712070936.67547-1-tmricht@linux.ibm.com>
Reply-To: raspl@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180712070936.67547-1-tmricht@linux.ibm.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 12.07.2018 09:09, Thomas Richter wrote:
> With commit eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
> s390 platform provides detailed type/model/capacitiy information
> in the CPU indentifier string instead of just "IBM/S390".
> 
> This breaks perf kvm support which uses hard coded string IBM/S390 to
> compare with the CPU identifier string. Fix this by changing the comparison.
> 
> Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
> Cc: Stefan Raspl <raspl@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # 4.17
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>


Reported-and-tested-by: Stefan Raspl <raspl@linux.ibm.com>
