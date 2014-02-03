From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Perf mem report Data Object
Date: Mon, 03 Feb 2014 19:32:37 +0100
Message-ID: <52EFE0C5.1030805@gmail.com>
References: <CALbiyZzdM84Cy+sodbuxPxT1jRZs4W94-N0KCjyaw3K89Edh3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:46727 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbaBCSck (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Feb 2014 13:32:40 -0500
Received: by mail-we0-f170.google.com with SMTP id w62so2832868wes.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2014 10:32:39 -0800 (PST)
Received: from [192.168.0.10] (mut38-6-88-167-68-98.fbx.proxad.net. [88.167.68.98])
        by mx.google.com with ESMTPSA id q15sm45982471wjw.18.2014.02.03.10.32.38
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 10:32:38 -0800 (PST)
In-Reply-To: <CALbiyZzdM84Cy+sodbuxPxT1jRZs4W94-N0KCjyaw3K89Edh3w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Anyone else is having the same error (warning) message ?

Manu

On 01/29/2014 02:53 PM, Manuel Selva wrote:
> Hi all,
>
> The perf mem report tools shows me a warning before printing results:
>
> Failed to open /tmp/perf-8741.map, continuing without symbols
>
> Then it seems that all the memory accesses which source address (Data
> Symbol field in perf mem rep output) is located in the heap of the
> profiled process is reported as "perf-8741.map" in the Data Object
> field.
>
> I am not sure to understand what this file is, what it should contain,
> and why it's not created when my process is profiled ?
>
> Moreover, I am wondering what perf mem could report for heap data
> object in addition to the fact that the object is in the heap ?
>
> Thanks,
>
> -------
> Manu
>
